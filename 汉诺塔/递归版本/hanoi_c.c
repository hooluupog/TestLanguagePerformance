#include "stdio.h"
#include "sys/time.h"

int count = 0; //全局变量，对搬动计数
//linux equivalent of windows GetTickCount.
unsigned long GetTickCount()
{
    struct timespec ts;
    int rc;
    if((rc = clock_gettime(CLOCK_MONOTONIC,&ts) != 0)){
        printf("can't gettime,rc=%d\n",rc);
    }
    return (ts.tv_sec*1000) + (ts.tv_nsec/1000000);
}

void hanoi(int n,char x,char y,char z)
{
    if(n == 1){
        count++;
        //printf("%d. Move disk %d from %c to %c\n",++count,n,x,z);
    }
    else{
        hanoi(n-1,x,z,y);
        count++;
        //printf("%d. Move disk %d from %c to %c\n",++count,n,x,z);
        hanoi(n-1,y,x,z);
    }
}
int main(){
    unsigned long start = 0;
    unsigned long end = 0;
    start = GetTickCount();
    hanoi(25,'A','B','C');
    end = GetTickCount();
    printf("%lums\n",(end-start));
}
