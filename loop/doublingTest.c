#include "stdio.h"
int Count(int a[],int len){
    int cnt = 0,i,j,k;
    for (i = 0; i < len; i++) {
        for (j = i + 1; j < len; j++) {
            for (k = j + 1; k < len; k++) {
                if (a[i]+a[j]+a[k] == 0) {
                    cnt++;
                }
            }
        }
    }
    return cnt;
}

int timeTrial(int n) {
    int a[n],i,cnt;
    for (i = 0; i < n; i++) {
        a[i] = i + 1;
    }
    return Count(a,n);
}
int main() {
    int res;
    res = timeTrial(250);
    res = timeTrial(500);
    res = timeTrial(1000);
    res = timeTrial(2000);
    return 0;
}
