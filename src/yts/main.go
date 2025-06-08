package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"net/url"
	"os"
	"regexp"
	"strings"
)

type YTResult struct {
	title string
	url string
}


func getTitle(videoRenderer map[string]any) string {
	title := videoRenderer["title"]
	runs := title.(map[string]any)["runs"]
	runs0 := runs.([]any)[0]
	text := runs0.(map[string]any)["text"]

	return text.(string)
}

func getUrl(videoRenderer map[string]any) string {
	videoId := videoRenderer["videoId"]

	return fmt.Sprintf("https://youtube.com/watch?v=%s&hl=en", videoId.(string))
}

func (result *YTResult) toString() string {
	return fmt.Sprintf(
		"%s;%s",
		strings.ReplaceAll(result.title, ";", ""),
		result.url,
	)
}

func isShort(videoRenderer map[string]any) bool {
	navigationEndpoint , ok := videoRenderer["navigationEndpoint"]
	if ! ok { return false }

	commandMetadata, ok := navigationEndpoint.(map[string]any)["commandMetadata"]
	if ! ok { return false }

	webCommandMetadata, ok := commandMetadata.(map[string]any)["webCommandMetadata"]
	if ! ok { return false }

	url, ok := webCommandMetadata.(map[string]any)["url"]
	if ! ok { return false }

	return strings.Contains(url.(string), "shorts")
}


// I admit perplexity did the work there
// It extract the sub-json of the form "key": {...} from the string data, which
// may contain extra html
func extractJSONObjectByKey(data, key string) (string, bool) {
	// Find the key and the opening curly brace
	pattern := fmt.Sprintf(`"%s"\s*:\s*{`, regexp.QuoteMeta(key))
	re := regexp.MustCompile(pattern)
	loc := re.FindStringIndex(data)
	if loc == nil {
		return "", false
	}
	start := loc[1] - 1 // position of the '{'

	// Now scan forward, counting braces and brackets
	depthBraces := 0
	depthBrackets := 0
	inString := false
	escapeNext := false

	for i := start; i < len(data); i++ {
		c := data[i]

		if escapeNext {
			escapeNext = false
			continue
		}
		if c == '\\' && inString {
			escapeNext = true
			continue
		}
		if c == '"' {
			inString = !inString
			continue
		}
		if inString {
			continue
		}

		switch c {
		case '{':
			depthBraces++
		case '}':
			depthBraces--
			if depthBraces == 0 && depthBrackets == 0 {
				return data[start : i+1], true
			}
		case '[':
			depthBrackets++
		case ']':
			depthBrackets--
		}
	}
	return "", false
}


func main() {
	urlPrefix := "https://youtube.com/results?q="
	if len(os.Args) <= 1 {
		fmt.Printf("Usage: %s ...words\n", os.Args[0])
		os.Exit(1)
	}

	args := os.Args[1:]
	joined := strings.Join(args, " ")

	url := fmt.Sprintf("%s%s", urlPrefix, url.QueryEscape(joined))

	resp, err := http.Get(url)
	if err != nil {
		log.Fatal(err)
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		log.Fatal(err)
	}

	obj, found := extractJSONObjectByKey(string(body), "itemSectionRenderer")
	if ! found {
		log.Fatal("Couldn't scrape the results")
	}

	var raw any
	json.Unmarshal([]byte(obj), &raw)
	dataMap := raw.(map[string]any)

	// Access and loop over "contents"
	contents, ok := dataMap["contents"].([]any)
	if !ok {
		log.Fatal(`"contents" is not an array`)
	}

	results := make([]YTResult, 0)

	for _, item := range contents {
		video, ok := item.(map[string]any)
		if ! ok {
			continue
		}

		// If it is not a short
		videoRenderer, ok := video["videoRenderer"]
		if ! ok {
			continue
		}
		videor := videoRenderer.(map[string]any)

		if isShort(videor) {
			continue
		}

		results = append(results, YTResult{
			title: getTitle(videor),
			url: getUrl(videor),
		})
	}

	for _, result := range results {
		fmt.Println(result.toString())
	}
}
