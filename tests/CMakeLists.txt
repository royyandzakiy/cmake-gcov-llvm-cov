# tests/CMakeLists.txt
include("${CMAKE_CURRENT_SOURCE_DIR}/../cmake/coverage.cmake")

# Set the output directory for the test executable
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})

add_executable(${PROJECT_NAME}_test 
	test.cpp 
	../src/helper/util.cpp)