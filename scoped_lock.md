# scoped_lock

`std::scoped_lock` 是 C++17 标准库提供的一个 RAII 类型，用于管理多个互斥量的锁定和解锁。与 `std::lock_guard` 类似，`std::scoped_lock` 会在构造函数中锁定所有传递给它的互斥量，并在析构函数中解锁所有互斥量，从而避免手动管理锁的繁琐和可能出现的错误。与 `std::lock_guard` 不同的是，`std::scoped_lock` 支持锁定多个互斥量，并提供了更灵活的锁定方式，从而避免了死锁的风险。

下面是一个简单的示例程序，展示了如何使用 `std::scoped_lock`：

```c++
#include <mutex>
#include <iostream>

std::mutex mtx1, mtx2;

void increment(int& x) {
    std::scoped_lock lock(mtx1, mtx2);
    ++x;
}

int main() {
    int count = 0;
    std::thread t1([&count]() { for (int i = 0; i < 10000; ++i) increment(count); });
    std::threadt2([&count]() { for (int i = 0; i < 10000; ++i) increment(count); });
    t1.join();
    t2.join();
    std::cout << "count = " << count << std::endl;
    return 0;
}
```

在上面的示例程序中，`std::scoped_lock` 对象 `lock` 的构造函数会依次尝试对 `mtx1` 和 `mtx2` 进行锁定操作，而在 `std::scoped_lock` 对象 `lock` 的作用域结束时，析构函数会自动解锁 `mtx1` 和 `mtx2`。这样，我们就可以在多线程程序中安全地对 `count` 进行自增操作，并且不会出现死锁的情况。

需要注意的是，`std::scoped_lock` 并不是一个可拷贝的类型，因此不能将其作为函数参数传递或者返回。同时，`std::scoped_lock` 也不支持手动解锁操作，因此需要在需要手动解锁的场景下使用 `std::unique_lock` 类型。