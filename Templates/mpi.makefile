CC = mpicc
RUN = mpirun
CFLAGS = -std=c99
LDFLAGS= 

all: build

%.o: %.c
	$(CC) -c -o $@ $(CFLAGS) $<

build: main.o
	$(CC) -o main $(LDFLAGS) $<

run:
	mpirun main

clean:
	$(RM) $(wildcard *.o) main

.PHONY: all build clean run
