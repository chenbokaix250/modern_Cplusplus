# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/code/user/boost_coroutine

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/code/user/boost_coroutine/build

# Include any dependencies generated for this target.
include CMakeFiles/demo1.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/demo1.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/demo1.dir/flags.make

CMakeFiles/demo1.dir/demo4.cpp.o: CMakeFiles/demo1.dir/flags.make
CMakeFiles/demo1.dir/demo4.cpp.o: ../demo4.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/code/user/boost_coroutine/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/demo1.dir/demo4.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/demo1.dir/demo4.cpp.o -c /home/code/user/boost_coroutine/demo4.cpp

CMakeFiles/demo1.dir/demo4.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/demo1.dir/demo4.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/code/user/boost_coroutine/demo4.cpp > CMakeFiles/demo1.dir/demo4.cpp.i

CMakeFiles/demo1.dir/demo4.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/demo1.dir/demo4.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/code/user/boost_coroutine/demo4.cpp -o CMakeFiles/demo1.dir/demo4.cpp.s

# Object files for target demo1
demo1_OBJECTS = \
"CMakeFiles/demo1.dir/demo4.cpp.o"

# External object files for target demo1
demo1_EXTERNAL_OBJECTS =

demo1: CMakeFiles/demo1.dir/demo4.cpp.o
demo1: CMakeFiles/demo1.dir/build.make
demo1: /usr/lib/x86_64-linux-gnu/libboost_system.so.1.71.0
demo1: /usr/lib/x86_64-linux-gnu/libboost_coroutine.so.1.71.0
demo1: /usr/lib/x86_64-linux-gnu/libboost_chrono.so.1.71.0
demo1: /usr/lib/x86_64-linux-gnu/libboost_context.so.1.71.0
demo1: /usr/lib/x86_64-linux-gnu/libboost_thread.so.1.71.0
demo1: /usr/lib/x86_64-linux-gnu/libboost_atomic.so.1.71.0
demo1: CMakeFiles/demo1.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/code/user/boost_coroutine/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable demo1"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/demo1.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/demo1.dir/build: demo1

.PHONY : CMakeFiles/demo1.dir/build

CMakeFiles/demo1.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/demo1.dir/cmake_clean.cmake
.PHONY : CMakeFiles/demo1.dir/clean

CMakeFiles/demo1.dir/depend:
	cd /home/code/user/boost_coroutine/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/code/user/boost_coroutine /home/code/user/boost_coroutine /home/code/user/boost_coroutine/build /home/code/user/boost_coroutine/build /home/code/user/boost_coroutine/build/CMakeFiles/demo1.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/demo1.dir/depend

