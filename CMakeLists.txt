cmake_minimum_required(VERSION 3.6)
project(coverage-example)

if (DEFINED WIN32)
	message(FATAL_ERROR "only runs on linux!")
endif()

if(ENABLE_COVERAGE)
  # set compiler flags
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O0 -coverage")

  # find required tools
  find_program(LCOV lcov REQUIRED)
  find_program(GENHTML genhtml REQUIRED)

  # add coverage target
  add_custom_target(coverage
    # Gather data: Look for .gcda files specifically in the current binary directory
    COMMAND ${LCOV} --directory ${CMAKE_BINARY_DIR} --capture --output-file coverage.info
    # Clean up the output by removing system headers
    COMMAND ${LCOV} --remove coverage.info '/usr/*' --output-file coverage.info --ignore-errors unused
    # Generate report
    COMMAND ${GENHTML} --demangle-cpp -o coverage_report coverage.info
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
  )
endif()

add_executable(test test.cpp helper/util.cpp)