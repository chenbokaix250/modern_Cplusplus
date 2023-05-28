# notify(one/all)

`notify_one()` 和 `notify_all()` 是 C++11 标准库提供的两个方法，用于唤醒等待在条件变量上的线程。

`notify_one()` 方法会随机选择一个等待在条件变量上的线程进行唤醒，如果没有线程在等待，则该方法不会产生任何效果。通常情况下，使用 `notify_one()` 方法可以避免不必要的唤醒操作，从而提高程序的性能。

下面是一个简单的示例程序，展示了如何使用 `notify_one()` 方法：

```c++
#include <condition_variable>
#include <iostream>
#include <thread>

std::mutex mtx;
std::condition_variable cv;
bool ready = false;

void task() {
    std::unique_lock<std::mutex> lock(mtx);
    while (!ready) {
        cv.wait(lock);
    }
    std::cout << "Task is running..." << std::endl;
}

int main() {
    std::thread t(task);
    std::this_thread::sleep_for(std::chrono::seconds(2));
    {
        std::lock_guard<std::mutex> lock(mtx);
        ready = true;
    }
    cv.notify_one();
    t.join();
    return 0;
}
```

在上面的示例程序中，`task()` 函数通过使用 `std::unique_lock` 对象 `lock` 锁定了 `std::mutex` 对象 `mtx`，并在 `while` 循环中等待条件变量 `cv` 的满足。在 `main()` 函数中，通过使用 `std::lock_guard` 对象 `lock` 锁定了 `std::mutex` 对象 `mtx`，将变量 `ready` 设置为 `true`，然后调用 `cv.notify_one()` 方法唤醒等待在条件变量 `cv` 上的一个线程。在 `task()` 函数中，当条件变量 `cv` 被唤醒时，线程被唤醒并执行任务。

`notify_all()` 方法会唤醒所有等待在条件变量上的线程，如果没有线程在等待，则该方法不会产生任何效果。通常情况下，使用 `notify_all()` 方法可以确保所有等待的线程都能够及时得到通知，从而避免线程因为等待而一直阻塞的风险。

下面是一个简单的示例程序，展示了如何使用 `notify_all()` 方法：

```#include <condition_variable>
#include <iostream>
#include <thread>
#include <vector>

std::mutex mtx;
std::condition_variable cv;
bool ready = false;

void task() {
    std::unique_lock<std::mutex> lock(mtx);
    while (!ready) {
        cv.wait(lock);
    }
    std::cout << "Task is running..." << std::endl;
}

int main() {
    std::vector<std::thread> threads;
    for (int i = 0; i < 5; ++i) {
        threads.emplace_back(task);
    }
    std::this_thread::sleep_for(std::chrono::seconds(2));
    {
        std::lock_guard<std::mutex> lock(mtx);
        ready = true;
    }
    cv.notify_all();
    for (auto& t : threads) {
        t.join();
    }
    return 0;
}
```

在上面的示例程序中，`main()` 函数启动了五个线程，并通过使用 `std::lock_guard` 对象 `lock` 锁定了 `std::mutex` 对象 `mtx`，将变量 `ready` 设置为 `true`，然后调用 `cv.notify_all()` 方法唤醒所有等待在条件变量 `cv` 上的线程。在 `task()` 函数中，当条件变量 `cv` 被唤醒时，所有等待的线程都被唤醒并执行任务。

需要注意的是，`notify_one()` 和 `notify_all()` 方法只会唤醒等待在条件变量上的线程，而不会解锁互斥量。因此，在调用 `notify_one()` 或 `notify_all()` 方法前，必须先通过使用 `std::unique_lock` 或 `std::lock_guard` 对象锁定互斥量。同时，线程在等待条件变量的过程中，会自动释放锁，当条件变量被唤醒时，线程会重新获取锁并继续执行。
