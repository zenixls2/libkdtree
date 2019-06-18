cmake_minimum_required(VERSION 2.6)
project(kdtree)

find_package(SWIG REQUIRED)
include(${SWIG_USE_FILE})

find_package(PythonLibs)
include_directories(${PYTHON_INCLUDE_PATH})
file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/generated)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/py-kdtree.i.tmpl ${CMAKE_BINARY_DIR}/generated/py-kdtree.i.tmpl)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/py-kdtree.hpp.tmpl ${CMAKE_BINARY_DIR}/generated/py-kdtree.hpp.tmpl)
execute_process(COMMAND python ${CMAKE_CURRENT_SOURCE_DIR}/gen-swig-hpp.py WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/generated/)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/..)
include_directories(${CMAKE_BINARY_DIR}/generated/)

# Build the _kdtree python module
set_source_files_properties(${CMAKE_BINARY_DIR}/generated/py-kdtree.i PROPERTIES CPLUSPLUS ON)

if(CMAKE_VERSION VERSION_LESS 3.8)
    swig_add_module(kdtree python ${CMAKE_BINARY_DIR}/generated/py-kdtree.i)
else()
    swig_add_library(kdtree LANGUAGE python SOURCES ${CMAKE_BINARY_DIR}/generated/py-kdtree.i)
endif()
swig_link_libraries(kdtree ${PYTHON_LIBRARIES})

# Copy the test file into the build dir
install(FILES py-kdtree_test.py DESTINATION ${CMAKE_INSTALL_PREFIX}/python)
install(FILES ${CMAKE_BINARY_DIR}/python-bindings/kdtree.py DESTINATION ${CMAKE_INSTALL_PREFIX}/python)
install(FILES ${CMAKE_BINARY_DIR}/python-bindings/_kdtree.so DESTINATION ${CMAKE_INSTALL_PREFIX}/python)

