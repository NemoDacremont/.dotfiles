RUSTC ?= rustc

PHONY += all
all: build

PHONY += build
build: main

%: %.rs
	$(RUSTC) -o $@ $^

PHONY += clean
clean:
	$(RM) -f main

.PHONY: $(PHONY)
