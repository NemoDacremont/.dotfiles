CC=g++
CLFAGS+=-Wall -g
LDFLAGS+=

all: build

build: main

main: main.cpp
	${CC} -o main main.cpp ${CLFAGS} ${LDFLAGS}

clean:
	${RM} -f *.o main

.phony: all build clean
