%module kdtree
%include <std_common.i>

%{
#include "kdtree++/function.hpp"
%}
namespace KDTree {
template<typename _Val>
struct _Bracket_accessor {
    typedef typename _Val::value_type result_type;
    result_type operator()(_Val const& V, size_t const N);
};

template<typename _Tp, typename _Dist>
struct squared_difference {
    typedef _Dist distance_type;
    distance_type operator() (const _Tp& __a, const _Tp& __b);
};

}
