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

## via CMake (old)
```bash
royya@tuff16:~/project-coding/cpp/202604/gcov-test-cmake$ mkdir build
royya@tuff16:~/project-coding/cpp/202604/gcov-test-cmake$ cd build/
royya@tuff16:~/project-coding/cpp/202604/gcov-test-cmake/build$ cmake -DENABLE_COVERAGE=true .. && make
-- The C compiler identification is GNU 13.3.0
-- The CXX compiler identification is GNU 13.3.0
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/c++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Configuring done (0.5s)
-- Generating done (0.0s)
-- Build files have been written to: /home/royya/project-coding/cpp/202604/gcov-test-cmake/build
[ 50%] Building CXX object CMakeFiles/test.dir/test.cpp.o
[100%] Linking CXX executable test
[100%] Built target test
royya@tuff16:~/project-coding/cpp/202604/gcov-test-cmake/build$ ./test && make coverage
Capturing coverage data from .
geninfo cmd: '/usr/bin/geninfo . --output-filename coverage.info --memory 0'
Found gcov version: 13.3.0
Using intermediate gcov format
Writing temporary data to /tmp/geninfo_datwacV
Scanning . for .gcda files ...
Found 1 data files in .
Processing ./CMakeFiles/test.dir/test.cpp.gcda
Finished .info-file creation
Found 1 entries.
Found common filename prefix "/home/royya/project-coding/cpp/202604"
Generating output.
Processing file gcov-test-cmake/test.cpp
  lines=7 hit=6 functions=2 hit=2
Overall coverage rate:
  lines......: 85.7% (6 of 7 lines)
  functions......: 100.0% (2 of 2 functions)
Built target coverage
royya@tuff16:~/project-coding/cpp/202604/gcov-test-cmake/build$ 
```