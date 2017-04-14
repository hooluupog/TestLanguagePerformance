#include <iostream>

int main(){
    for(int i = 0;i < 1 << 25;i++){
        std::cout << i << '\n';
    }
    std::cout << std::endl;
    return 0;
}

