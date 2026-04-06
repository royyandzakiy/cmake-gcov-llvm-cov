# GCov Code Coverage Report Generation

This project runs coverage on a build, then generates html report

## via CMakePresets
### Code Coverage
```bash
# Configuration and compilation in build/coverage/
cmake --preset coverage
cmake --build --preset build-coverage

# Run the binary from the specific coverage folder
./build/coverage/coverage-example

# Generate report (LCOV will look inside build/coverage/)
cmake --build --preset report
```

### Normal Build
```bash
# Configuration and compilation in build/default/
cmake --preset default
cmake --build --preset build-default
```

## via CMake
```bash
# 1. Configure and Build
cmake -DENABLE_COVERAGE=true -B build
cmake --build build

# 2. RUN the program (This creates the .gcda files)
./build/coverage-example

# 3. Now run the coverage target to collect that data
cmake --build build --target coverage
```

## Result
### GCC: gcov
```bash
[main] Building folder: /home/royya/project-coding/cpp/202604/gcov-test-cmake/build/coverage-gcc 
[build] Starting build
[driver] NOTE: You are building with preset report-gcc, but there are some overrides being applied from your VS Code settings.
[proc] Executing command: /usr/bin/cmake --build /home/royya/project-coding/cpp/202604/gcov-test-cmake/build/coverage-gcc --target coverage --
[build] [ 75%] Built target test
[build] [100%] Generating GCC coverage report
[build] Capturing coverage data from /home/royya/project-coding/cpp/202604/gcov-test-cmake/build/coverage-gcc
[build] geninfo cmd: '/usr/bin/geninfo /home/royya/project-coding/cpp/202604/gcov-test-cmake/build/coverage-gcc --output-filename /home/royya/project-coding/cpp/202604/gcov-test-cmake/build/coverage-gcc/coverage.info --base-directory /home/royya/project-coding/cpp/202604/gcov-test-cmake --ignore-errors gcov --ignore-errors graph --ignore-errors version --ignore-errors source --memory 0'
[build] Found gcov version: 13.3.0
[build] Using intermediate gcov format
[build] Writing temporary data to /tmp/geninfo_datdEWU
[build] Scanning /home/royya/project-coding/cpp/202604/gcov-test-cmake/build/coverage-gcc for .gcda files ...
[build] Found 2 data files in /home/royya/project-coding/cpp/202604/gcov-test-cmake/build/coverage-gcc
[build] Processing /home/royya/project-coding/cpp/202604/gcov-test-cmake/build/coverage-gcc/tests/CMakeFiles/test.dir/__/src/helper/util.cpp.gcda
[build] Processing /home/royya/project-coding/cpp/202604/gcov-test-cmake/build/coverage-gcc/tests/CMakeFiles/test.dir/test.cpp.gcda
[build] Finished .info-file creation
[build] lcov: WARNING: ('unused') 'exclude' pattern '/usr/*' is unused.
[build] Excluding /home/royya/project-coding/cpp/202604/gcov-test-cmake/tests/test.cpp
[build] Removed 1 files
[build] Writing data to /home/royya/project-coding/cpp/202604/gcov-test-cmake/build/coverage-gcc/coverage_filtered.info
[build] Summary coverage rate:
[build]   lines......: 100.0% (2 of 2 lines)
[build]   functions..: 100.0% (1 of 1 function)
[build]   branches...: no data found
[build] Found 1 entries.
[build] Using user-specified filename prefix "/home/royya/project-coding/cpp/202604/gcov-test-cmake"
[build] Generating output.
[build] Processing file src/helper/util.cpp
[build]   lines=2 hit=2 functions=1 hit=1
[build] Overall coverage rate:
[build]   lines......: 100.0% (2 of 2 lines)
[build]   functions......: 100.0% (1 of 1 function)
[build] [100%] Built target coverage
[driver] Build completed: 00:00:00.810
[build] Build finished with exit code 0
```

### Clang: llvm-cov
```bash
[main] Building folder: /home/royya/project-coding/cpp/202604/gcov-test-cmake/build/coverage-clang 
[build] Starting build
[driver] NOTE: You are building with preset report-clang, but there are some overrides being applied from your VS Code settings.
[proc] Executing command: /usr/bin/cmake --build /home/royya/project-coding/cpp/202604/gcov-test-cmake/build/coverage-clang --target coverage --
[build] [ 75%] Built target test
[build] [100%] Generating Clang coverage report with llvm-cov
[build] Filename                      Regions    Missed Regions     Cover   Functions  Missed Functions  Executed       Lines      Missed Lines     Cover    Branches   Missed Branches     Cover
[build] --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
[build] src/helper/util.cpp                 1                 0   100.00%           1                 0   100.00%           3                 0   100.00%           0                 0         -
[build] tests/test.cpp                      6                 1    83.33%           2                 0   100.00%          11                 1    90.91%           2                 1    50.00%
[build] --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
[build] TOTAL                               7                 1    85.71%           3                 0   100.00%          14                 1    92.86%           2                 1    50.00%
[build] [100%] Built target coverage
[driver] Build completed: 00:00:00.327
[build] Build finished with exit code 0

```