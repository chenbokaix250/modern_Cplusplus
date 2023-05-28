在C++中，`std::mutex`是一个线程同步原语，用于保护共享资源的访问。`std::mutex`提供了两个基本操作：lock()和unlock()。当一个线程调用`lock()`时，如果mutex没有被锁定，则该线程将锁定mutex，并且可以安全地访问共享资源。如果mutex已经被锁定，则该线程将被阻塞，直到mutex被解锁为止。当一个线程调用`unlock()`时，它会释放对mutex的锁定，这样其他线程就可以访问共享资源了。

下面是一个简单的例子，演示了如何使用`std::mutex`来保护一个共享变量的访问：

```cpp
#include <iostream>
#include <thread>
#include <mutex>

std::mutex mtx;  // 全局的互斥量

int shared_variable = 0;  // 要保护的共享变量

void increment() {
    for (int i = 0; i < 1000000; ++i) {
        mtx.lock();  // 加锁
        ++shared_variable;
        mtx.unlock();  // 解锁
    }
}

int main() {
    std::thread t1(increment);
    std::thread t2(increment);

    t1.join();
    t2.join();

    std::cout << "shared_variable = " << shared_variable << std::endl;

    return 0;
}
```

在上面的例子中，首先定义了一个全局的互斥量`mtx`和一个共享变量`shared_variable`，然后定义了一个函数`increment`，它会对共享变量进行1000000次加1操作。在`increment`函数中，首先调用`mtx.lock()`来锁定互斥量，然后进行加1操作，最后调用`mtx.unlock()`来解锁互斥量。在`main`函数中，创建了两个线程`t1`和`t2`，它们都调用`increment`函数对共享变量进行操作。最后输出共享变量的值。

需要注意的是，在使用`std::mutex`时，必须确保所有线程都能够访问到mutex对象，否则就无法保护共享资源的访问。另外，使用`std::mutex`时，应该尽量减少锁的持有时间，这样可以最大程度地减少线程之间的阻塞，提高程序的并发性能。如果需要在锁定期间进行复杂的计算或I/O操作，可以考虑使用RAII技术，即在构造函数中锁定互斥量，在析构函数中解锁互斥量，从而避免手动调用`lock()`和`unlock()`函数，例如：

```cpp
#include <iostream>
#include <thread>
#include <mutex>

std::mutex mtx;  // 全局的互斥量

int shared_variable = 0;  // 要保护的共享变量

class LockGuard {
public:
    LockGuard(std::mutex& mtx) : mtx_(mtx) {
        mtx_.lock();
    }

    ~LockGuard() {
        mtx_.unlock();
    }

private:
    std::mutex& mtx_;
};

void increment() {
    for (int i = 0; i < 1000000; ++i) {
        LockGuard lock(mtx);  // 加锁
        ++shared_variable;
    }
}

int main() {
    std::thread t1(increment);
    std::thread t2(increment);

    t1.join();
    t2.join();

    std::cout << "shared_variable =" << shared_variable << std::endl;

    return 0;
}
```

在上面的例子中，定义了一个名为`LockGuard`的类，它在构造函数中锁定互斥量，在析构函数中解锁互斥量。在`increment`函数中，使用`LockGuard`类创建一个名为`lock`的对象，这样可以保证在`lock`对象的生命周期内，互斥量一直被锁定，从而保护共享变量的访问。