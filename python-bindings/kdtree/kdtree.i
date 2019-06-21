%module kdtree
%include <std_common.i>
%include <std_vector.i>
%include <iterator.i>

%{
#include <iterator>
#include "kdtree++/node.hpp"
#include "kdtree++/iterator.hpp"
#include "kdtree++/kdtree.hpp"
%}

%define BASE_DEFINE(T)
    %template(Vector_ ## T) std::vector<##T>;
    %template(node_ ##T) KDTree::_Node<std::vector<##T> >;
    %template(iterator_ ##T) KDTree::_Iterator<std::vector<##T>, std::vector<##T>&, std::vector<##T>*>;
    %template(const_iterator_ ##T) KDTree::_Iterator<std::vector<##T>, std::vector<##T> const&, std::vector<##T> const*>;
    %template(iterator_traits_ ##T) std::iterator_traits<KDTree::_Iterator<std::vector<##T>, std::vector<##T> const&, std::vector<##T> const*> >;
    %template(base_iterator_ ##T) std::iterator<std::bidirectional_iterator_tag, std::vector<##T>, ptrdiff_t, std::vector<##T> const*, std::vector<##T> const&>;
    %template(reverse_iterator_ ##T) std::reverse_iterator<KDTree::_Iterator<std::vector<##T>, std::vector<##T> const&, std::vector<##T> const*> >;

%enddef

BASE_DEFINE(int);
BASE_DEFINE(long);
BASE_DEFINE(double);
BASE_DEFINE(float);

namespace KDTree {
template <typename _Val,
          typename _Acc = _Bracket_accessor<_Val>,
          typename _Dist = squared_difference<typename _Acc::result_type,
                                              typename _Acc::result_type>,
          typename _Cmp = std::less<typename _Acc::result_type>,
          typename _Alloc = std::allocator<_Node<_Val> > >
class KDTree : protected _Alloc_base<_Val, _Alloc> {
public:
    typedef _Val value_type;
    typedef value_type* pointer;
    typedef value_type const* const_pointer;
    typedef value_type& reference;
    typedef value_type const& const_reference;
    typedef size_t size_type;
    typedef ptrdiff_t difference_type;
    typedef _Iterator<_Val, const_reference, const_pointer> const_iterator;
    typedef const_iterator itertator;
    typedef std::reverse_iterator<const_iterator> const_reverse_iterator;
    typedef std::reverse_iterator<iterator> reverse_iterator;
    KDTree(size_type n);
    KDTree(const KDTree& __x);
    size_type size() const;
    size_type dimension() const;
    %rename(isEmpty) empty;
    bool empty() const;
    void clear();
    %rename(add) insert;
    void insert(const value_type& __V);
    %rename(remove) erase;
    void erase(const value_type& __V);
    void optimise();
    void optimize();
    void check_tree();

    _Iterator<_Val, _Val const&, _Val const*> begin() const;
    _Iterator<_Val, _Val const&, _Val const*> end() const;
    std::reverse_iterator<
        _Iterator<_Val, _Val const&, _Val const*> > rbegin() const;
    std::reverse_iterator<
        _Iterator<_Val, _Val const&, _Val const*> > rend() const;

};
%define KDTREE_DEFINE(T)
    %template(KDTree_ ## T) KDTree<std::vector<##T> >;
%enddef

KDTREE_DEFINE(int);
KDTREE_DEFINE(long);
KDTREE_DEFINE(double);
KDTREE_DEFINE(float);

}

