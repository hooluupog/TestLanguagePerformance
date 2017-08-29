#include <unordered_map>

int main(){
    std::unordered_map<int,int> a;
    for (int i = 0; i < 100000000; i++) {
        a.insert(std::make_pair(i & 0xffff,i));
    }
}
