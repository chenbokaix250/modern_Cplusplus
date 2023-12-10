#include <iostream>
#include <boost/coroutine2/all.hpp>

void foo(boost::coroutines2::coroutine<std::string>::pull_type & sink){
    std::cout<<"get"<<sink.get()<<"from main() \n";
    sink();
    std::cout<<"get"<<sink.get()<<"from main() \n";
    sink();
}

int main(){
    std::string str1("hello");
    std::string str2("world");
    boost::coroutines2::coroutine<std::string>::push_type source(foo);
    std::cout<<"pass"<<str1<<"to foo()\n";
    source(str1);
    std::cout<<"pass"<<str2<<"to foo()\n";
    source(str2);
    return 0;
}