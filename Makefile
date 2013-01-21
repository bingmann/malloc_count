# Simplistic Makefile for malloc_count

CC = gcc
CFLAGS = -g -W -Wall -D_GNU_SOURCE -ansi
LDFLAGS =
LIBS = -ldl

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

test: test.o malloc_count.o
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ test.o malloc_count.o $(LIBS)

clean:
	rm -f *.o test
