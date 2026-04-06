# tests/CMakeLists.txt
include("${CMAKE_CURRENT_SOURCE_DIR}/../cmake/coverage.cmake")

add_executable(test 
	test.cpp 
	../src/helper/util.cpp)