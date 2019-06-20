%module kdtree
%include <std_common.i>
%include <std_vector.i>
%include <iterator.i>

%{
#include "kdtree++/node.hpp"
#include "kdtree++/iterator.hpp"
#include "kdtree++/kdtree.hpp"
%}

%define VECTOR_DEFINE(T)
    %template(Vector_ ## T) std::vector<##T>;
    %template(node_ ##T) KDTree::_Node<std::vector<##T> >;
    %template(iterator_ ##T) KDTree::_Iterator<std::vector<##T>, std::vector<##T>&, std::vector<##T>*>;
    %template(const_iterator_ ##T) KDTree::_Iterator<std::vector<##T>, std::vector<##T> const&, std::vector<##T> const*>;

%enddef

VECTOR_DEFINE(int);
VECTOR_DEFINE(long);
VECTOR_DEFINE(double);
VECTOR_DEFINE(float);

namespace KDTree {
/*struct _Node_base {
    _Node_base* _M_parent;
    _Node_base* _M_left;
    _Node_base* _M_right;
    _Node_base(_Node_base* const parent=NULL,
               _Node_base* const left=NULL,
               _Node_base* const right=NULL);
};


template<typename _Val>
struct _Node : public _Node_base {
    _Val _M_value;
    _Node(_Val const& __VALUE = _Val(),
          _Node_base* const __PARENT=NULL,
          _Node_base* const __LEFT=NULL,
          _Node_base* const __RIGHT=NULL);
};*/

/*class _Base_iterator {
protected:
    typedef _Node_base const* _Base_const_ptr;
    _Base_iterator(_Base_const_ptr const __N = NULL);
    _Base_iterator(_Base_iterator const& __THAT);
};


template<typename _Val, typename _Ref, typename _Ptr>
class _Iterator : protected _Base_iterator {
public:
    typedef _Val value_type;
    typedef _Ref reference;
    typedef _Ptr pointer;
    typedef _Iterator<_Val, _Val&, _Val*> iterator;
    typedef _Iterator<_Val, _Val const&, _Val const*> const_iterator;
    typedef _Iterator<_Val, _Ref, _Ptr> _Self;
    typedef _Node<_Val> const* _Link_const_type;
    typedef std::bidirectional_iterator_tag iterator_category;
    typedef ptrdiff_t difference_type;

    _Iterator();
    _Iterator(_Iterator<_Val, _Val&, _Val*> const& __THAT);
    %rename(get) operator*();
    _Ref operator*() const;
    _Ptr operator->() const;
    %rename(next) operator++;
    _Iterator<_Val, _Ref, _Ptr> operator++();
    %rename(prev) operator--;
    _Iterator<_Val, _Ref, _Ptr> operator--();
};
*/
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
    /*_Iterator<_Val, _Val const&, _Val const*> end() const;
    std::reverse_iterator<
        _Iterator<_Val, _Val const&, _Val const*> > rbegin() const;
    std::reverse_iterator<
        _Iterator<_Val, _Val const&, _Val const*> > rend() const;*/

};
%define KDTREE_DEFINE(T)
    /*%template(node_ ## T) _Node<std::vector<##T> >;
    %template(const_iterator_ ## T) _Iterator<std::vector<##T>, std::vector<##T> const&, std::vector<##T> const* >;
    %template(iterator_ ## T) _Iterator<std::vector<##T>, std::vector<##T>&, std::vector<##T>* >;*/
    %template(KDTree_ ## T) KDTree<std::vector<##T> >;
%enddef

KDTREE_DEFINE(int);
KDTREE_DEFINE(long);
KDTREE_DEFINE(double);
KDTREE_DEFINE(float);

}

/*%define ITERATOR_DEFINE(T)
    %template(const_iterator_ ## T) KDTree::_Iterator<std::vector<##T>, std::vector<##T> const&, std::vector<##T> const* >;
%enddef

ITERATOR_DEFINE(int);*/

