#include "stdio.h"
#include <stack>
#include "stdlib.h"
#include "sys/time.h"
using namespace std;

typedef struct HanoiState {
    int n, disk;
    char x, y, z;
}Hanoi;

void hanoi(int n,char x,char y, char z) {
    int count = 0;
    Hanoi hs = {n, n, x, y, z};
    stack<HanoiState> s;
    Hanoi tmp = hs;
    s.push(hs);
    while(!s.empty()) { 
        hs = s.top();
        s.pop();
        tmp = hs;
        if (hs.n == 1) {
            count++;
            //printf("%d. Move disk %d from %c to %c\n", count, hs.disk,hs.x,hs.z);
        }
        else {
            //参考递归版本的实现，这里的顺序和递归函数调用恰好相反的
            hs = {tmp.n - 1, tmp.n - 1, tmp.y, tmp.x, tmp.z};
            s.push(hs);
            hs = {1, tmp.n, tmp.x, tmp.y, tmp.z};
            s.push(hs);
            hs = {tmp.n - 1, tmp.n - 1, tmp.x, tmp.z, tmp.y};
            s.push(hs);
        }
    }
}

unsigned long GetTickCount()
{
    struct timeval tv;
    if(gettimeofday(&tv,NULL)!=0)
        return 0;
    return (tv.tv_sec*1000) + (tv.tv_usec/1000);
}

int main(){
    unsigned long start = 0;
    unsigned long end = 0;
    start = GetTickCount();
    hanoi(25,'A','B','C');
    end = GetTickCount();
    printf("%lums\n",(end-start));
}
