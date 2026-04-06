# cmake/coverage.cmake
if(ENABLE_COVERAGE)
	if (DEFINED WIN32)
		message(FATAL_ERROR "only runs on linux!")
	endif()

    # Find required tools
    find_program(LCOV lcov REQUIRED)
    find_program(GENHTML genhtml REQUIRED)
    
    # Handle GCC vs Clang differently
    if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        # Use Clang's native coverage tools (recommended for Clang)
        message(STATUS "Setting up Clang coverage with llvm-cov")
        
        find_program(LLVM_PROFDATA llvm-profdata REQUIRED)
        find_program(LLVM_COV llvm-cov REQUIRED)
        
        # Set Clang-specific coverage flags
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O0 -fprofile-instr-generate -fcoverage-mapping")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O0 -fprofile-instr-generate -fcoverage-mapping")
        
        # Create wrapper script for llvm-cov gcov (for LCOV compatibility if needed)
        set(GCOV_WRAPPER "${CMAKE_BINARY_DIR}/llvm-gcov.sh")
        file(WRITE ${GCOV_WRAPPER} "#!/bin/bash\nexec ${LLVM_COV} gcov \"$@\"\n")
        file(CHMOD ${GCOV_WRAPPER} PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
        
        # Main coverage target using llvm-cov directly (cleaner for Clang)
        add_custom_target(coverage
            # Run the test executable to generate profiling data
            COMMAND ${CMAKE_BINARY_DIR}/test
            # Merge raw profile data
            COMMAND ${LLVM_PROFDATA} merge -sparse ${CMAKE_BINARY_DIR}/default.profraw -o ${CMAKE_BINARY_DIR}/coverage.profdata
            # Generate HTML report
            COMMAND ${LLVM_COV} show ${CMAKE_BINARY_DIR}/test -instr-profile=${CMAKE_BINARY_DIR}/coverage.profdata -format=html -o ${CMAKE_BINARY_DIR}/coverage_report
            # Generate text summary (print to console)
            COMMAND ${LLVM_COV} report ${CMAKE_BINARY_DIR}/test -instr-profile=${CMAKE_BINARY_DIR}/coverage.profdata
            # Clean up raw profile
            COMMAND ${CMAKE_COMMAND} -E remove ${CMAKE_BINARY_DIR}/default.profraw
            WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
            DEPENDS test
            COMMENT "Generating Clang coverage report with llvm-cov"
        )
        
        # Optional: LCOV-compatible target (if you need LCOV format)
        add_custom_target(coverage-lcov
            # Run test to generate .gcda files
            COMMAND ${CMAKE_BINARY_DIR}/test
            # Use lcov with gcov wrapper
            COMMAND ${LCOV} --gcov-tool ${GCOV_WRAPPER} --directory ${CMAKE_BINARY_DIR} --capture --output-file ${CMAKE_BINARY_DIR}/coverage.info --ignore-errors gcov,graph,version
            # Remove system files
            COMMAND ${LCOV} --remove ${CMAKE_BINARY_DIR}/coverage.info '/usr/*' --output-file ${CMAKE_BINARY_DIR}/coverage.info --ignore-errors unused,version
            # Generate HTML report
            COMMAND ${GENHTML} --demangle-cpp -o ${CMAKE_BINARY_DIR}/coverage_report_lcov ${CMAKE_BINARY_DIR}/coverage.info
            WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
            DEPENDS test
            COMMENT "Generating Clang coverage report with LCOV (alternative)"
        )
        
    else()
        # GCC coverage setup
        message(STATUS "Setting up GCC coverage with gcov/lcov")
        
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O0 --coverage")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O0 --coverage")
        
        # Add coverage target for GCC
        add_custom_target(coverage
            # Run test to generate .gcda files
            COMMAND ${CMAKE_BINARY_DIR}/test
            # Capture coverage data
            COMMAND ${LCOV} --directory ${CMAKE_BINARY_DIR} --capture --output-file ${CMAKE_BINARY_DIR}/coverage.info --ignore-errors gcov,graph,version
            # Remove system files
            COMMAND ${LCOV} --remove ${CMAKE_BINARY_DIR}/coverage.info '/usr/*' --output-file ${CMAKE_BINARY_DIR}/coverage.info --ignore-errors unused,version
            # Generate HTML report
            COMMAND ${GENHTML} --demangle-cpp -o ${CMAKE_BINARY_DIR}/coverage_report ${CMAKE_BINARY_DIR}/coverage.info
            WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
            DEPENDS test
            COMMENT "Generating GCC coverage report"
        )
    endif()
endif()