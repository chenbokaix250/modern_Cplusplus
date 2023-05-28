# lock_guard

`std::lock_guard` 是一个 C++11 标准库提供的 RAII（资源获取即初始化）类型，用于管理互斥量（`std::mutex`）的锁定和解锁。RAII 是一种编程技术，通过在对象的构造函数中获取资源，在对象的析构函数中释放资源，来确保资源的正确管理。在多线程程序中，`std::lock_guard` 可以保证互斥量在作用域结束时自动解锁，避免了手动管理锁的繁琐和可能出现的错误。

下面是一个简单的示例程序，展示了如何使用 `std::lock_guard`：

```c++
#include <mutex>
#include <iostream>

std::mutex mtx;

void increment(int& x) {
    std::lock_guard<std::mutex> lock(mtx);
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

在上面的示例程序中，`std::lock_guard` 对象 `lock` 的构造函数会尝试对 `mtx` 进行锁定，而在 `std::lock_guard` 对象 `lock` 的作用域结束时，析构函数会自动解锁 `mtx`。这样，我们就可以在多线程程序中安全地对 `count` 进行自增操作，而无需担心竞争条件的出现。

需要注意的是，`std::lock_guard` 并不是一个可拷贝的类型，因此不能将其作为函数参数传递或者返回。此外，`std::lock_guard` 也不支持手动解锁操作，因此需要在需要手动解锁的场景下使用 `std::unique_lock` 类型。

## 如何理解这句话 td::lock_guardstd::mutex lock(mtx);

这句话定义了一个 `std::lock_guard` 对象 `lock`，它的模板参数是 `std::mutex` 类型，并将 `mtx` 对象传递给了构造函数，在构造函数中对 `mtx` 进行了锁定操作。

具体来说，`std::lock_guard` 是一个 RAII 类型，它的构造函数会尝试对 `std::mutex` 类型的对象进行锁定操作，而在 `std::lock_guard` 对象的作用域结束时，析构函数会自动解锁 `std::mutex` 类型的对象。因此，通过定义一个 `std::lock_guard` 对象 `lock` 并将 `mtx` 对象传递给构造函数，就可以在 `lock` 对象的作用域内自动锁定 `mtx` 对象，并在 `lock` 对象的作用域结束时自动解锁 `mtx` 对象。

需要注意的是，`std::lock_guard` 是一个智能指针类型，它的构造函数并不会返回一个指向 `std::mutex` 对象的指针，而是返回一个包含 `std::mutex` 对象的引用的对象。因此，在使用 `std::lock_guard` 时不需要手动释放锁，因为 `std::lock_guard` 的析构函数会自动释放锁。同时，由于 `std::lock_guard` 不支持拷贝或赋值操作，因此不能将它作为函数参数传递或返回。


---

