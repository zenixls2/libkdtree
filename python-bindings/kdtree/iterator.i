%module kdtree
%include <std_common.i>
%include <std_vector.i>
%include <node.i>

%{
#include <iterator>
#include "kdtree++/iterator.hpp"
%}
namespace std {
template<typename _Category, typename _Tp, typename _Distance = ptrdiff_t,
         typename _Pointer, typename _Reference>
struct iterator {
    typedef _Category iterator_category;
    typedef _Tp value_type;
    typedef _Distance difference_type;
    typedef _Pointer pointer;
    typedef _Reference reference;
};

template<typename _Iterator>
struct iterator_traits {
    typedef typename _Iterator::itertaor_category iterator_category;
    typedef typename _Iterator::value_type value_type;
    typedef typename _Iterator::difference_type difference_type;
    typedef typename _Iterator::pointer pointer;
    typedef typename _Iterator::reference reference;

};

template<typename _Iterator>
class reverse_iterator
: public iterator<typename _Iterator::iterator_category,
                  typename _Iterator::value_type,
                  typename _Iterator::difference_type,
                  typename _Iterator::pointer,
                  typename _Iterator::reference> {
public:
    /* from stl_iterator_base_types.h struct iterator_traits */
    typedef _Iterator iterator_type;
    typedef typename _Iterator::itertaor_category iterator_category;
    typedef typename _Iterator::value_type value_type;
    typedef typename _Iterator::difference_type difference_type;
    typedef typename _Iterator::pointer pointer;
    typedef typename _Iterator::reference reference;

    reverse_iterator();
    reverse_iterator(iterator_type __x);
    reverse_iterator(const reverse_iterator<_Iterator>& x);
    iterator_type base() const;
    %extend {
        const value_type& get() throw (std::runtime_error) {
            _Iterator __tmp = self->base();
            return *(--__tmp);
        }
        const reverse_iterator<_Iterator> next() {
            /* cannot call the operator directly */
            _Iterator __tmp = self->base();
            --__tmp;
            std::reverse_iterator<_Iterator> iter(__tmp);
            *self = iter;
            return iter;
        }
        const reverse_iterator<_Iterator> prev() {
            /* cannot call the operator directly */
            _Iterator __tmp = self->base();
            ++__tmp;
            std::reverse_iterator<_Iterator> iter(__tmp);
            *self = iter;
            return iter;
        }
        bool __eq__(reverse_iterator<_Iterator> o) {
            return *self == o;
        }
    }
};
}
namespace KDTree {
class _Base_iterator {
public:
    typedef _Node_base const* _Base_const_ptr;
    _Base_const_ptr _M_node;
    _Base_iterator(_Base_const_ptr const __N = NULL);
    _Base_iterator(_Base_iterator const& __THAT);
};
%ignore *::operator*();
%ignore *::operator->();
template<typename _Val, typename _Ref, typename _Ptr>
class _Iterator : public _Base_iterator {
    using _Base_iterator::_M_node;
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
    _Iterator(_Link_const_type const __N);
    _Iterator(iterator const& __THAT);
    %extend {
        const _Val& get()  throw (std::runtime_error) {
            if (self == NULL || self->get_raw_node() == NULL)
                throw std::runtime_error("no value stored in iterator");
            return (((KDTree::_Node<_Val> const*)self->get_raw_node())->_M_value);
        }
        _Self next() {
            self->_M_increment();
            return *self;
        }
        _Self prev() {
            self->_M_decrement();
            return *self;
        }
        bool __eq__(const _Iterator<_Val, _Ref, _Ptr> o) {
            return *self == o;
        }
    }
};
}
