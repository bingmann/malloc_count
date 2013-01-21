# README for malloc_count #

malloc_count provides a method to measure the amount of allocated memory of a
program at run-time.

It intercepts the standard heap allocation functions malloc(),free(),realloc()
and calloc() and adds simple counting statistics to each call. 

## Short Usage Guide ##

Compile `malloc_count.c` and link it with your program. The source file
malloc_count.o should be located towards the end of the `.o` file sequence.

Run your program and observe that when terminating, it outputs a line like

    "malloc_count ### exiting, total: 12,582,912, peak: 4,194,304, current: 0"

If desired, increase verbosity

1. by setting `log_operations = 1` at the top of `malloc_count.c` and adapting
   `log_operations_threshold` to output only large allocations.

2. by including `malloc_count.h` in your program and using the user-functions
   define therein to output memory usage at specific checkpoints.

Tip: Set the locale environment variable `LC_NUMERIC=en_GB` or similar to get
comma-separation of thousands in the printed numbers.

## Technicalities of Intercepting libc Function Calls ##

The method used in malloc_count to hook the standard heap allocation calls is
to provide a source file exporting the symbols "malloc", "free", etc. These
override the libc symbols and thus the functions in malloc_count are used
instead.

However, malloc_count does not implement a heap allocator. It loads the symbols
"malloc", "free", etc. directly using the dynamic link loader "dl" from the
chain of shared libraries. Calls to the overriding "malloc" functions are
forwarded to the usual libc allocator.

To keep track of the size of each allocated memory area, malloc_count uses a
trick: it prepends each allocation pointer with two size_t variables: the
allocation size and a sentinel value. Thus when allocating n bytes, in truth n
+ 16 bytes are requested from the libc malloc() to save the size. The sentinel
only serves as a check that your program has not overwritten the size
information.

## Closing Credits ##

Written 2013-01-21 by Timo Bingmann <tb@panthema.net>
