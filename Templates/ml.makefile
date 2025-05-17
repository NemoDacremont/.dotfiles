all: build
	./main

build: main

helloworld: main.ml
	ocamlc -o main main.ml

clean:
	rm -rf main *.cmi *.cmo

.phony: clean all build
