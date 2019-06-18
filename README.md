libkdtree++ README
==================

libkdtree++ is (c) 2004-2007 Martin F. Krafft <libkdtree@pobox.madduck.net>
and distributed under the terms of the Artistic License 2.0.
See the file LICENSE in the source distribution for more information.

Please send bugreports to <libkdtree-devel@lists.alioth.debian.org>.

Introduction
------------

libkdtree++ is a C++ template container implementation of k-dimensional space
sorting, using a kd-tree. It:

  - sports an unlimited number of dimensions (in theory)
  - can store any data structure, access and comparison between the
    individual dimensional components defaults to the bracket operator, in
    the range [0, k-1] and the std::less functor by default, but other
    accessors and comparator can be defined.
  - has support for custom allocators
  - implements iterators
  - provides standard find as well as range queries
  - has amortised O(lg n) time (O(n lg n) worst case) on most
    operations (insert/erase/find optimised) and worst-case O(n) space.
  - provides a means to rebalance and thus optimise the tree.
  - exists in its own namespace
  - uses STL coding style, basing a lot of the code on stl\_tree.h

Notes
-----

Note that the library is not (yet) complete and it's not thoroughly tested.
However, given the effort and grief I went through in writing it, I would
like to make it available to folks, get people to test it, and hopefully have
some peeps submit improvements. If you have any suggestions, please write to
libkdtree-devel@lists.alioth.debian.org .

It's not yet documented, although the usage should be fairly straight
forward. I am hoping to find someone else to document it as I suck at
documentation and as the author, it's exceptionally difficult to stay
didactically correct.

Credits (Martin F. Kraft)
-------------------------

While the library was written all by myself, it would not have been possible
without the help of a number of people. Foremost, I would like to thank the
folks from the #c++ channel on Freenode, specifically (in no particular order)
orbitz, quix, Erwin, pwned, wcstok, dasOp, Chaku, Adrinael, The\_Vulture, and
LIM2 (if I left anyone out, let me know). Finally, I thank the Artificial
Intelligence Laboratory of the University of Zurich, Dr. Peter Eggenberger and
Gabriel G�mez for giving me the opportunity to write this stuff.

Since libkdtree++ makes an effort to stay as close as possible to the feel of
a STL container, concepts and inspiration was gained from the SGI C++
implementation of red-black trees (stl\_tree.h).

I also have to thank the Debian project for providing an amazingly reliable
and flexible developer station with their operating system. I am sorry for
everyone who has to use something else.

Installation
------------

As there is no need to compile any files, you can just:

```bash
./configure
sudo make install
```


It now also supports cmake, which can be used to build the examples
and tests.
To build with cmake, do an out-of-source build like so:

```bash
# ASSUMING you have decompressed it into a directory called libkdtree,
# and you are currently in that directory...

mkdir build
cd build
cmake ..
make
```


You can use cmake to build the tests and examples on Windows with
Visual C++.  Use the windows cmake to create a Visual C++ solution and
build that.

Note that cmake and ./configure is not needed at all in order to use
kdtree in your application.  As kdtree is a header-only library, you
just need to #include the kdtree.hpp


Read the following to make use of the library.

Usage
-----

A simple example program is provided in the ./examples directory
(/usr/share/doc/libkdtree++-dev/examples on Debian).

For those using the ./configure system, the library supports pkg-config.
Thus, to compile with the library,

```c++
  #include <kdtree++/kdtree.hpp>
```

and append the output of `pkg-config libkdtree++ --cflags` to your $CPPFLAGS.

Each call to erase() and insert() unbalances the tree.  It is possible that
nodes will not be found while the tree is unbalanced.  You rebalance the
tree by calling optimize(), and you should call it before you need to search
the tree (this includes erase(value) calls, which search the tree).  

It is ok to call insert(value) many times and optimize() at the end, but 
every erase() call should be followed with optimize().

These notes are a bit out of date, please check the webpage and mailing list
for more info.  Documentation is on the TODO list.

Have fun.
