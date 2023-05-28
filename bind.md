# bind

可以用来绑定函数的参数,从而产生一个新的函数

```c++
#include <iostream>
#include <functional>

void foo(int a,int b,int c){
    std::cout << a << ", " << b << ", " << c << std::endl;
}

int main() {
    auto f1 = std::bind(foo,1,2,3);
    f1();
    auto f2 = std::bind(foo,std::placeholders::_1,std::placeholders::_2,4);
    f2(5,6);
    return 0;
}

```

首先定义了一个函数foo，它接受三个整数参数并输出它们的值。然后使用std::bind创建了两个新的函数对象。其中，f1绑定了参数1、2和3，所以当调用f1时，它会调用foo(1, 2, 3)；f2绑定了参数3和4，以及两个占位符std::placeholders::_1和std::placeholders::_2，表示它需要接受两个整数参数，它们将分别替换占位符_1和_2。因此，当调用f2(5, 6)时，它会调用foo(5, 6, 4)。

std::bind返回的是一个函数对象，可以将它赋值给一个变量，也可以直接调用它。如果要绑定的函数是成员函数，需要使用类的实例作为第一个参数

```c++
class A {
public:
    void foo(int a, int b, int c) {
        std::cout << a << ", " << b << ", " << c << std::endl;
    }
};

int main() {
    A a;
    autof = std::bind(&A::foo, &a, 1, 2, 3);
    f(); // 输出：1, 2, 3

    return 0;
}
```

在使用std::bind绑定成员函数时，需要注意两点：

由于成员函数需要通过类的实例来调用，所以需要在绑定成员函数时，将类的实例作为第一个参数传递给std::bind。因此，绑定成员函数时需要使用取地址符&获取成员函数的地址，并将类的实例作为第一个参数传递给std::bind。

由于成员函数是属于类的，所以需要在绑定成员函数时，使用作用域解析运算符::来指定成员函数所属的类。

综上所述，对于一个类A中的成员函数foo，正确的使用std::bind绑定成员函数的写法应该是std::bind(&A::foo, &a, arg1, arg2, ...)，其中&A::foo表示成员函数foo的地址，&a表示类的实例a的地址，arg1, arg2, ...表示要绑定的其他参数。

因此，如果将std::bind(&A::foo, &a, arg1,arg2, ...)写成A::foo是不正确的，因为A::foo只是成员函数foo的名称，而不是成员函数的地址。如果将A::foo作为绑定的函数，编译器会报错。