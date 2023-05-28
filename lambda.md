Lambda 是 C++11 标准引入的一种匿名函数类型，可以方便地定义一个函数对象（functor）。Lambda 表达式提供了一种更加简洁、灵活的方式来定义函数对象，尤其是在需要传递函数对象作为参数的场合下非常有用。

下面是一个简单的 Lambda 示例程序，展示了如何使用 Lambda：

```c++
#include <iostream>
#include <vector>
#include <algorithm>

int main() {
    std::vector<int> v = {1, 2, 3, 4, 5};
    std::for_each(v.begin(), v.end(), [](int x) {
        std::cout << x << " ";
    });
    std::cout << std::endl;
    return 0;
}
```

在上面的示例程序中，Lambda 表达式 `[](int x) { std::cout << x << " "; }` 定义了一个函数对象，它接受一个参数 `x`，并将其输出到标准输出流中。在 `main()` 函数中，通过使用 `std::for_each()` 算法对向量 `v` 中的每个元素都应用了这个 Lambda 表达式，并将其输出到屏幕上。

Lambda 表达式的基本语法如下：

```c++
[capture-list] (parameter-list) -> return-type { body }
```

其中，`capture-list` 是捕获列表，用于捕获外部变量；`parameter-list` 是参数列表，用于声明函数对象的参数；`return-type` 是返回值类型，可以省略；`body` 是函数体，用于定义函数对象的实现。

捕获列表中可以包含以下三种类型的元素：

- 值捕获（value capture）：以值的方式捕获外部变量，可以使用 `=` 或指定变量名来进行值捕获；
- 引用捕获（reference capture）：以引用的方式捕获外部变量，可以使用 `&` 或指定变量名来进行引用捕获；
- 隐式捕获（implicit capture）：根据上下文自动推断需要捕获的外部变量，可以使用 `[&]` 或 `[=]` 来进行隐式捕获。

Lambda 表达式还支持一些其他的语法特性，例如可以忽略参数列表（`[]() -> void{}`），可以省略返回类型（`[]() { return 0; }`），可以使用 `auto` 关键字来推断返回类型（`[]() { return "Hello, world!"; }`）等等。

Lambda 表达式可以与 STL 中的算法和容器一起使用，方便地实现各种操作。例如，可以使用 Lambda 表达式来实现一个自定义的排序算法：

```c++
#include <iostream>
#include <vector>
#include <algorithm>

int main() {
    std::vector<int> v = {5, 3, 1, 4, 2};
    std::sort(v.begin(), v.end(), [](int x, int y) {
        return x > y;
    });
    std::for_each(v.begin(), v.end(), [](int x) {
        std::cout << x << " ";
    });
    std::cout << std::endl;
    return 0;
}
```

在上面的示例程序中，Lambda 表达式 `[](int x, int y) { return x > y; }` 定义了一个比较函数，用于按照降序对向量 `v` 进行排序。在 `std::sort()` 算法中，通过将这个 Lambda 表达式作为第三个参数传递给 `std::sort()`，实现了自定义的排序操作。在 `main()` 函数中，通过使用 `std::for_each()` 算法对排序后的向量 `v` 中的每个元素都应用了另一个 Lambda 表达式，将其输出到屏幕上。

除了在 STL 中的算法和容器中使用 Lambda 表达式之外，Lambda 表达式还可以用于各种其他的场合，例如在多线程编程中，可以使用 Lambda 表达式来实现线程函数、互斥量和条件变量等。Lambda 表达式的灵活性和方便性使得它成为 C++11 中一个非常重要的特性，值得开发者们深入学习和掌握。