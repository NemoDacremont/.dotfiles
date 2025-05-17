CC=g++
CLFAGS+=
LDFLAGS+=

all: build
	[ -x main ] && time ./main < in

build: main

main: solve.cpp
	${CC} -o main solve.cpp ${CLFAGS} ${LDFLAGS}

clean:
	${RM} -f *.o main

setup: in solve.cpp

in:
	[ -f in ] || echo -n > in

solve.cpp:
	[ -f solve.cpp ] || cp ${HOME}/Templates/main.cf.cpp solve.cpp

.phony: all build clean setup
