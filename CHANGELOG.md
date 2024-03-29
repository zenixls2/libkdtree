libkdtree++ ChangeLog
=====================
### 2019-06-17  zenix huang <zenixls2@gmail.com>

  - Add find\_n\_nearest. Add tests to find\_n\_nearest
  - merge nvmd's branch and debian patches to the code base
  - fix compilation issues. Now able to compile with gcc-9.0.0
    fix examples according to the changes by nvmd.

### 2008-11-17  Sylvain Bougerel  <sylvain.bougerel@asia.thalesgroup.com>

  - Added #include<cstdio> in order to compile 'printf' statements in the
    file 'examples/test_find_within_range.cpp'.
  - Added patch from Max Fellermann in order to compile libkdtree++ with
    clang++.

### 2009-02-10  Paul Harris <paulharris@computer.org>

  - Bug fix: was incorrectly casting a pointer when the search key type
    was different to the stored type.

### 2008-12-30  Paul Harris <paulharris@computer.org>

  - New function: efficient\_replace\_and\_optimise().
    Yes, its a long name. Sylvain doesn't like it.
    The reason for the long name is that it is a dangerous function,
    and it will resort whatever vector<> of data that you pass it.
    So I wanted the user to really know what they were doing before
    they called this function.
  - Now calls sqrt() when required in order to search for items
    in 'real' distance units... And so it will accept and return distance
    in 'real' units (as opposed to squared units).
    This is not an ideal solution, we have all sorts of ideas to improve
    kdtree which will include less calls to sqrt() for more speed, and
    the ability to change the standard euclidean distance measurements
    for distance-on-a-sphere or whatever the user wants.
  - Changed from using std::sort() to std::nth\element() when optimising
    the tree. Performance boost.
  - Added lots of tests to check that the find functions are working
    correctly when fed edge-cases, including:
    - Items that are exactly 'max' distance away from the target.
    - When there are no value items to find.
  - Templated the find functions so that the target/center point can be
    anything that can be accessed via the Accessor.
  - Fixes to make it compile.

  - And, a Python wrapper !   See README.Python

  - CMake support now can build the python wrapper and install the headers
    and the python wrapper to a destination folder.  Its simple, but neat.
    Does not install python module into the python site packages or anything
    like that.

### 2008-11-17  Sylvain Bougerel  <sylvain.bougerel@asia.thalesgroup.com>

  - The version number of the library is now part of the headers.
  - Fixed a bug with assignment operator.
  - Fixed uninitialized memory problem with valgrind, when printing the
    content of the tree. Due to the fact the _M_header was a _Link_type
    instead of a _Node_base type and _M_root was a _Base_ptr type instead of
    a _Link_type.
  - Paul Harris fixed find() by ensuring that the correct node is being
    matched during a find(). Thus, fixed a similar problem in erase. Paul
    also added a new test courtesy of Hayne.
  - Paul Harris augmented test\_kdtree with various test on copy
    construction, assignment, and formatting operator.
  - Paul Harris added support for CMake, which should suit not only
    MSVC users but others too.
  - Paul Harris fixed bug with compiling with MSVC2005 with the 64bit
    warnings turned on.

### 2008-11-12  Sylvain Bougerel  <sylvain.bougerel@asia.thalesgroup.com>

  - Fix segfault on the regular iterator when \_M\_header->\_M\_right ==
    \_M\_root. Fix segfault on the reverse iterator when \_M\_header->\_M\_left ==
    \_M\_root.

  Besides, it also change the behavior when iterating past the end() or
  rend(). Previously this would result in segfaults, now it makes the
  iterator points to an undetermined location in the tree, similarly to
  the current implementation of GNU libstdc++.

### 2008-11-10  Sylvain Bougerel  <sylvain.bougerel@asia.thalesgroup.com>

  - kdtree++/iterator.hpp (KDTree): the decrement iterator was
    ill-written. Its buggy behavior, and the use of non-standard
    reverse_iterator initialiser needed to be fixed. These error were do to
    a previous failed attempt by me at fixing the reverse_iterator.

    This time, I believe I got it right, however it needed the kdtree
    structure to be modified. The reason is that without modification it is
    not possible to distinguish the "header" from the "root" within the
    iterator. This is required for the reverse_iterator to work properly.

    Now the kdtree has an additional pointer that points directly to the
    root. The parent pointer of the header is permanently null. And
    therefore the header can be distinguished from the root within the
    iterator by checking the parent of the current node: if it is null, we
    are at the header.


### 2008-11-10 Sylvain Bougerel (sylvain.bougerel.devel@gmail.com)

  - patch from Martin Shreiber to make libkdtree to compile with newer
    version of g++-4.2 and g++4.3.

  - patch from Paul Harris to make libkdtree more exception transparent.

### 2007-12-08 Sylvain Bougerel (sylvain.bougerel.devel@gmail.com)

  - fix bug where find\_nearest() could return the wrong value if a
    maximum distance greater than the root distance to the target value
    was given in argument to the function.

  - find\_nearest() still returns SQUARED value of the distance. You still
    have to use sqrt() on the second member of the iterator.

  - find\_nearest() behavior was slightly changed: if many nodes are at
    the same distance from the target value, the node with the lowest
    memory address will be returned. This is to catter for the
    reimplementation of find_exact() coming soon.

### 2007-12-02 Sylvain Bougerel (sylvain.bougerel.devel@gmail.com)

  - find\_nearest() now returned the SQUARED value of the distance for
    euclidean space calculation (the default). You have to use sqrt() on
    the returned distance (i.e. iterator->second) if you want to read the
    absolute distance returned by find_nearest. My apologies for not
    making highlighting this beforehand.

  - Increased the performance of find and find\_nearest/find\_nearest\_if by
    about 50x to 100x depending on your compilation flags.

  - KDTree are not defined as:
    KDTree<__K, _Val, _Acc, _Cmp, _Alloc>
    but as:
    KDTree<__K, _Val, _Acc, _Dist, _Cmp, _Alloc>
    So pay attention to the _Dist functor. The distance functor calculate
    the squared difference between 2 elements returned by the accessor. You
    might have to change your code to reflect the new definition, or it wont
    compile if you have set custom accessor and comparison functors.

  - The following functors are now accessible in the tree:
    - the comparison functor, accessible by copy only
    - the accessor functor, accessible by copy only
    - the distance functor, accessible read-write, this means that
    you can modify the behavior of find, find_nearest,
    find_nearest_if within the same KDTree object.

  - find\_exact has not be modified and retained the code of the former,
    slower algorithm. I have to write some more code to do this. Pls wait a
    little more.

  - The file accessor.hpp was renamed as function.hpp for it now boast
    more than just the KDTree accessor

### 2007-11-25 Sylvain Bougerel (sylvain.bougerel.devel@gmail.com)

  - fixed the reverse\_iterator. Now it can be used.

### 2007-10-24  Sylvain Bougerel (sylvain.bougerel.devel@gmail.com)

  - Removal of all the warnings that are yield by the compiler when
  using the following flags:
    -Wall -pedantic -ansi
  Do not hesitate to suggest any flags for additional code checking.

  This release also feature numerous of enhancements by Paul Harris
  (paulharris@computer.org):
    - const kdtrees can be searched
    - find\_nearest\_if() enforce validation of a predicate
    - visit\_within\_range() walk the tree and calls
      Visitor::operator() on template argument <Visitor> for
      each node within the range
  - find\_exact() matches an kdtree::value\_type by location and by
    calling kdtree::value_type::operator==() (in case two different
    items have the same location find_exact() will not return the
    wrong item)
  - erase\_exact() is to erase() what find\_exact() is to find()
  - check\_tree() and num\_dist\_calcs for debugging purpose plus
    additional improvements on erase and region intersection

### 2004-11-26  Paul Harris (paulharris@computer.org)

  - New feature: find\_nearest()
  - Accessors can now be initialised with the tree, so ptr\_fun() 
    or functors can be used to access datapoints.
  - Accessors now much more generic, so you can use the same 
    accessor to access multiple types.
  - Range-constructors now optimise() automatically, simplifying 
    the construction of a filled tree.
  - \_Range is now more easy to construct.

### 2004-11-15  Martin F. Krafft (libkdtree@pobox.madduck.net)

  - fixed numerous little bugs that led to compilation problems
  - changed code to compile cleanly with GCC 3.4 and GCC 4.0

### 2004-11-06  Martin F. Krafft (libkdtree@pobox.madduck.net)

  - reverted to optimise() to prevent API change, and added an optimize()
    passthrough method with an appropriate comment.

### 2004-11-05  Paul Harris (paulharris@computer.org)

  - Renamed optimise() to optimize().
  - Added a full set of range constructors and insert(range) methods.
    it now works with inserter(tree,tree.begin())
  - Target type no longer needs a default constructor. This also fixes
    problems with empty trees (would crash if optimized).
  - Some code cleanup (removed inlines, switched from const_iterator to
    iterator, added this-> to ensure the methods are called).
  - Added a new method: count\_within\_range().
  - Fixed bug in rend().

### 2004-11-04  Martin F. Krafft (libkdtree@pobox.madduck.net)

  - Integrated patch by Paul Harris to fix a logic error pertaining to
    OutputIterators in find_within_range. find_within_range() now
    returns the output iterator instead of a count. Thanks, Paul!
  - Added another fix by Paul Harris to \_M\_get\_j\_max, which would cause
    a dimensional overflow for trees with depths >= K. Thanks (again) Paul!
  - Made some improvements to the autotools files.

### 2004-05-11  Martin F. Krafft (libkdtree@pobox.madduck.net)

  - Fixed CFlags and Libs entries in pkgconfig file.

### 2004-05-11  Martin F. Krafft (libkdtree@pobox.madduck.net)

  - Initial release.


 COPYRIGHT --
 libkdtree++ is (c) 2004-2007 Martin F. Krafft <libkdtree@pobox.madduck.net> and
 Sylvain Bougerel <sylvain.bougerel.devel@gmail.com> and distributed under the
 terms of the Artistic License 2.0. See the ./COPYING file in the source tree
 root for more information.

 THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES,
 INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND
 FITNESS FOR A PARTICULAR PURPOSE.
