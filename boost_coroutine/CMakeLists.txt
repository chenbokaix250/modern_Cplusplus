cmake_minimum_required(VERSION 3.15)
project(BoostCoroutineExample)

# 设置 C++ 标准
set(CMAKE_CXX_STANDARD 14)

# 查找 Boost 库
find_package(Boost REQUIRED COMPONENTS system coroutine)
# 添加可执行文件
add_executable(demo1 demo4.cpp)

# 包含 Boost 头文件路径
target_include_directories(demo1 PRIVATE ${Boost_INCLUDE_DIRS})


# 链接 Boost 库
target_link_libraries(demo1 PRIVATE ${Boost_LIBRARIES})

