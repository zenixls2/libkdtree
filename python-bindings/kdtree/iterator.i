%module kdtree
%include <std_common.i>
%include <std_vector.i>
%include <node.i>

%{
#include "kdtree++/iterator.hpp"
%}

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
    }
};
}
