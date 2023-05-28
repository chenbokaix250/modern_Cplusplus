# atomic

`std::atomic` 是 C++11 标准库提供的一个类型，用于实现多线程之间的原子操作。`std::atomic` 支持原子的读、写和操作，能够确保在多线程环境中对变量的访问是线程安全的，从而避免了竞争条件的出现。

下面是一个简单的示例程序，展示了如何使用 `std::atomic`：

```c++
#include <atomic>
#include <iostream>
#include <thread>

std::atomic<int> count(0);

void increment() {
    for (int i = 0; i < 10000; ++i) {
        ++count;
    }
}

int main() {
    std::thread t1(increment);
    std::thread t2(increment);
    t1.join();
    t2.join();
    std::cout << "count = " << count << std::endl;
    return 0;
}
```

在上面的示例程序中，`std::atomic` 对象 `count` 的类型为 `int`，并且初始值为 `0`。在 `increment()` 函数中，通过使用 `++count` 操作对 `count` 进行自增操作。在 `main()` 函数中，启动了两个线程并同时调用 `increment()` 函数对 `count` 进行自增操作。由于 `std::atomic` 支持原子操作，因此在多线程环境中对 `count` 进行自增操作是线程安全的。

需要注意的是，`std::atomic` 在实现上使用硬件级别的原子操作，因此具有非常高的性能。同时，为了确保线程安全，所有对 `std::atomic` 对象的操作都必须是原子的，即对 `std::atomic` 对象的读、写和操作都必须是原子的。如果在多线程环境中对 `std::atomic` 对象进行非原子操作，可能会出现数据竞争的情况。

`std::atomic` 类型支持的操作包括原子的读、写和操作。其中，原子的读操作可以通过使用 `load()` 方法实现，原子的写操作可以通过使用 `store()` 方法实现，原子的操作可以通过使用 `fetch_add()`、`fetch_sub()` 以及其他一些方法实现。例如，可以通过下面的方式实现原子的加法操作：


std::atomic<int`std::atomic` 是 C++11 标准库提供的一个类型，用于实现多线程之间的原子操作。`std::atomic` 支持原子的读、写和操作，能够确保在多线程环境中对变量的访问是线程安全的，从而避免了竞争条件的出现。

下面是一个简单的示例程序，展示了如何使用 `std::atomic`：

```c++
#include <atomic>
#include <iostream>
#include <thread>

std::atomic<int> count(0);

void increment() {
    for (int i = 0; i < 10000; ++i) {
        ++count;
    }
}

int main() {
    std::thread t1(increment);
    std::thread t2(increment);
    t1.join();
    t2.join();
    std::cout << "count = " << count << std::endl;
    return 0;
}
```

在上面的示例程序中，`std::atomic` 对象 `count` 的类型为 `int`，并且初始值为 `0`。在 `increment()` 函数中，通过使用 `++count` 操作对 `count` 进行自增操作。在 `main()` 函数中，启面的示例程序中，可以通过下面的方式实现原子的加法操作：

```c++
std::atomic<int> count(0);

// 原子的加法操作
count.fetch_add(1);
```

在上面的示例程序中，`fetch_add()` 方法会将 `count` 的值原子地加上 `1`，并返回加法操作之前的值。如果需要实现其他类型的原子操作，可以参考 `std::atomic` 类型提供的其他方法进行实现。

需要注意的是，`std::atomic` 类型的对象可以被拷贝或赋值，因此可以将其作为函数参数传递或返回。如果需要将 `std::atomic` 对象传递给函数以在多个线程中使用，建议使用引用或指针类型，确保操作的原子性。同时，由于 `std::atomic` 对象的操作是原子的，因此可以用于实现锁和条件变量等同步机制，避免使用互斥量和信号量等较重量级的同步机制。