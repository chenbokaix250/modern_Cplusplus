#include <iostream>
#include <boost/coroutine2/all.hpp>

int main(){
    typedef boost::coroutines2::coroutine<int> coro_t2;
    coro_t2::pull_type source([&](coro_t2::push_type& sink){
        std::cout<<"coroutine 1"<<std::endl;
        sink(1);
        std::cout<<"coroutine 2"<<std::endl;
        sink(2);
        std::cout<<"coroutine 3"<<std::endl;
        sink(3);
    });

    while(source){
        int ret = source.get();
        std::cout<<"move tp coroutine-function"<<ret<<std::endl;
        source();
        std::cout<<"back from coroutine-function"<<std::endl;

    }

    return 0;
}