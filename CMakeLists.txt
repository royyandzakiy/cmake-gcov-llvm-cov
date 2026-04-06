cmake_minimum_required(VERSION 3.6)
project(coverage-example)

add_executable(${PROJECT_NAME} 
	src/main.cpp 
	src/helper/util.cpp)

add_subdirectory(tests)