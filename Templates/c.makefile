CLFLAGS=-std=c99
LDFLAGS=


all: build


install: build


%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)


build: main.o
	$(CC) -o main main.o $(LDFLAGS)


clean:
	$(RM) *.o main


.PHONY: all build install clean
