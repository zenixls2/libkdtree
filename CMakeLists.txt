project (libkdtree CXX)
cmake_minimum_required (VERSION 2.6.0)
enable_testing()

option (BUILD_PYTHON_BINDINGS "Build Python bindings (requires SWIG)")

if (WIN32)

   # Maximum warning level
   set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W4")

   # Be strict about warnings... make them errors
   # set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /WX")
   # Disabled for now, need to clean up size_t vs int usage,
   # compile in 64 bit mode to see warnings.

   # Detect 64-bit portability issues
   # set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /Wp64")
   # Disable, is deprecated in MSVC2010+

else (WIN32)

   # Maximum warning level
   set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")

   # turn on debugging
   set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g")

endif (WIN32)

if (BUILD_PYTHON_BINDINGS)
   add_subdirectory (python-bindings)
endif (BUILD_PYTHON_BINDINGS)

include_directories (${PROJECT_SOURCE_DIR})

add_subdirectory(examples)

file (GLOB KDTREE_HEADERS kdtree++/*.hpp)
install (FILES ${KDTREE_HEADERS} DESTINATION ${CMAKE_INSTALL_PREFIX}/include)

