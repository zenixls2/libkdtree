%module kdtree
%include <std_common.i>
%include <std_vector.i>

%{
#include "kdtree++/node.hpp"
%}

namespace KDTree {
struct _Node_base {
    typedef _Node_base* _Base_ptr;
    typedef _Node_base const* _Base_const_ptr;
    _Node_base* _M_parent;
    _Node_base* _M_left;
    _Node_base* _M_right;
    _Node_base(_Node_base* const parent=NULL,
               _Node_base* const left=NULL,
               _Node_base* const right=NULL);
};

template<typename T>
struct _Node : public _Node_base {
    using _Node_base::_M_parent;
    using _Node_base::_M_left;
    using _Node_base::_M_right;
    T _M_value;
    _Node(T const& __VALUE=_Val(),
          _Node_base* const parent=NULL,
          _Node_base* const left=NULL,
          _Node_base* const right=NULL);
};

}


