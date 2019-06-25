%module kdtree
%include <std_common.i>
%include <std_pair.i>

%{
#include "kdtree++/region.hpp"
%}

namespace KDTree {
template<typename _Val, typename _SubVal, typename _Acc, typename _Cmp>
struct _Region {
    typedef _Value value_type;
    typedef _SubVal subvalue_type;
    typedef std::pair<_Region, _SubVal> _CenterPtr;

    _Region(size_t __k, _Val const& __V, _Acc const& __acc=_Acc(), const _Cmp& __cmp=_Cmp());
    _Region(size_t __k, _Acc const& __acc=_Acc(), const _Cmp& __cmp=_Cmp());
    _Region(size_t __k, _Val const& __V,
        _SubVal const& __R, _Acc const& __acc=_Acc(), const _Cmp& __cmp=_Cmp());
    bool intersects_with(std::pair<_Region, _SubVal> const& __THAT) const;
    bool intersects_with(_Region<_Val, _SubVal, _Acc, _Cmp> const& __THAT) const;
    bool encloses(value_type const& __V) const;
    _Region<_Val, _SubVal, _Acc, _Cmp>& set_high_bound(value_type const& __V, size_t const __L);
    _Region<_Val, _SubVal, _Acc, _Cmp>& set_low_bound(value_type const& __V, size_t const __L);
};
}
