**`std::unordered_map`** 是C++标准库中提供的一个容器，用于实现无序映射（unordered mapping）。它基于哈希表（hash table）实现，提供了快速的插入、查找和删除操作。下面是* *`std::unordered_map`** 的一些特点和用法总结：

1. 包含头文件：为了使用 **`std::unordered_map`** ，需要包含头文件 **`<unordered_map>`**。

```cpp
#include <unordered_map>
```

1. 创建 **`std::unordered_map`** 对象：可以使用不同的方式来创建 **`std::unordered_map`** 对象。以下是两种常见的方式：
- 使用默认构造函数创建一个空的 **`std::unordered_map`** 对象。

```cpp
std::unordered_map<KeyType, ValueType> myMap;
```

- 使用初始化列表创建并初始化 **`std::unordered_map`** 对象。

```cpp

std::unordered_map<KeyType, ValueType> myMap = {
    {key1, value1},
    {key2, value2},
    // ...
};

```

1. 插入元素：可以使用 **`insert()`** 函数或者 **`[]`** 运算符来插入键值对元素到 **`std::unordered_map`** 中。

```cpp

myMap.insert(std::make_pair(key, value));  // 使用 insert() 函数插入元素
myMap[key] = value;                        // 使用 [] 运算符插入元素
```

1. 访问元素：使用 **`[]`** 运算符可以通过键来访问 **`std::unordered_map`** 中的元素。

```cpp

ValueType value = myMap[key];  // 通过键获取元素值
```

1. 查找元素：可以使用 **`find()`** 函数来查找指定键对应的元素。如果键存在，返回指向该元素的迭代器；如果键不存在，返回 **`end()`** 迭代器。

```cpp

auto iter = myMap.find(key);  // 查找元素
if (iter != myMap.end()) {
    // 元素存在
    // 使用 iter->first 访问键
    // 使用 iter->second 访问值
} else {
    // 元素不存在
}

```

1. 删除元素：可以使用 **`erase()`** 函数来删除指定键对应的元素。

```
cppCopy code
myMap.erase(key);  // 删除元素

```

1. 遍历元素：可以使用范围 **`for`** 循环或迭代器来遍历 **`std::unordered_map`** 中的元素。

```

// 使用范围 for 循环遍历元素
for (const auto& pair : myMap) {
    // 使用 pair.first 访问键
    // 使用 pair.second 访问值
}

// 使用迭代器遍历元素
for (auto iter = myMap.begin(); iter != myMap.end(); ++iter) {
    // 使用 iter->first 访问键
    // 使用 iter->second 访问值
}

```

这些是 **`std::unordered_map`** 的一些常见特点和用法。它提供了高效的键值对存储和查找功能，并且可以适应不同类型的键和值。使用 **`std::unordered_map`** 可以方便地实现对数据的映射和快速访问。