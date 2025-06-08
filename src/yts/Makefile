PREFIX=$(HOME)/.local

PHONY := all
all: build

PHONY := build
build: yts

yts: main.go
	go build -o $@ $^

PHONY := install
install: yts
	install yts "$(PREFIX)/bin"

PHONY := clean
clean:
	$(RM) yts

.PHONY: $(PHONY)
