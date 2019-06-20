all:
	swig -c++ -python kdtree.i
	g++ -O2 -fPIC -I../../ -I/home/AD/hansheng.huang/.pyenv/versions/3.6.4/include/python3.6m/ -c kdtree_wrap.cxx
	g++ -shared kdtree_wrap.o -o _kdtree.so

