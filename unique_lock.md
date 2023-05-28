# unique_lock

`std::unique_lock` 是 C++11 标准库提供的一个 RAII 类型，用于管理互斥量的锁定和解锁。与 `std::lock_guard` 类似，`std::unique_lock` 也会在构造函数中锁定互斥量，并在析构函数中解锁互斥量，从而避免手动管理锁的繁琐和可能出现的错误。与 `std::lock_guard` 不同的是，`std::unique_lock` 提供了更灵活的锁定方式，同时支持手动解锁操作和条件变量的使用。

下面是一个简单的示例程序，展示了如何使用 `std::unique_lock`：

```c++
#include <mutex>
#include <iostream>

std::mutex mtx;

void increment(int& x) {
    std::unique_lock<std::mutex> lock(mtx);
    ++x;
}

int main() {
    int count = 0;
    std::thread t1([&count]() { for (int i = 0; i < 10000; ++i) increment(count); });
    std::thread t2([&count]() { for (int i = 0; i < 10000; ++i) increment(count); });
    t1.join();
    t2.join();
    std::cout << "count = " << count << std::endl;
    return 0;
}
```

在上面的示例程序中，`std::unique_lock` 对象 `lock` 的构造函数会尝试对 `mtx` 进行锁定操作，而在 `std::unique_lock` 对象 `lock` 的作用域结束时，析构函数会自动解锁 `mtx`。这样，我们就可以在多线程程序中安全地对 `count` 进行自增操作，而无需担心竞争条件的出现。

需要注意的是，`std::unique_lock` 支持手动解锁操作，可以通过调用 `unlock()` 方法手动释放锁。此外，`std::unique_lock` 还支持条件变量的使用，可以通过调用 `wait()` 方法等待条件变量的满足，或者通过调用 `notify_one()` 或 `notify_all()` 方法唤醒等待的线程。同时，由于 `std::unique_lock` 支持拷贝或赋值操作，因此可以将它作为函数参数传递或返回。如果需要将 `std::unique_lock` 对象传递给函数，可以使用 `std::move()` 函数将其转移所有权，避免拷贝构造函数的调用。