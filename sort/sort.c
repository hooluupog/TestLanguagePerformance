#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#define INSERTSORT_THRESHOLD  32
#define timing(func) do { \
    clock_t start=clock();\
    func; \
    clock_t diff = clock() - start; \
    int msec = diff * 1000 / CLOCKS_PER_SEC; \
    printf("time used: %dms\n",msec); \
} while(0)

void swap(long *a,int i,int j){
    long temp = a[i];
    a[i] = a[j];
    a[j] = temp;
}

void insertSort(long *a,int start,int end) {
    int i;
    for (i = start + 1; i <= end; i++) {
        // 依次将a[1]~a[len-1]插入到前面已排序序列
        long temp = a[i]; // 暂存a[i]
        int l = start;
        int h = i - 1; // 设置折半查找范围
        while (l <= h) {
            // 开始折半查找(升序)
            int mid = (l + h) / 2; // 取中间点
            if (a[mid] > temp) {
                // 查找左半子表
                h = mid - 1;
            } else {
                // 查找右半子表
                l = mid + 1;
            }
        }
        for (int j = i - 1; j >= h + 1; j--) {
            // 统一后移元素，空出插入位置
            a[j + 1] = a[j];
        }
        a[h + 1] = temp; // 插入操作
    }
}

int partition(long *a,int start,int end) {
    int length = end - start + 1;
    srand((unsigned)time(NULL));
    int rIndex = start + rand() % length;
    // 将枢值交换到第一个元素
    swap(a,start,rIndex);
    long pivotkey = a[start]; // 置当前表中第一个元素为枢轴值
    int i = start,j = start + 1;
    for (; j <= end; j++) {
        // 从第二个元素开始找小于基准的元素
        if (a[j] < pivotkey) {
            // 找到和交换到前面
            i++;
            swap(a,i,j);
        }
    }
    // 将基准元素插入到最终位置
    swap(a,start,i);
    return i;
}

// Classic quicksort.
void sort(long *s,int start,int end) {
    int length = end - start + 1;
    if (length <= 1) {
        return;
    }
    if (length <= INSERTSORT_THRESHOLD) {
        insertSort(s,start,end);
        return;
    }
    int pivotIdx = partition(s,start,end);
    sort(s,start,pivotIdx-1);
    sort(s,pivotIdx + 1, end);
}

void print(long *a,int length){
    printf("[");
    int i;
    for(i = 0;i < length-1;i++){
        printf("%ld, ",a[i]);
    }
    printf("%ld]\n",a[i]);
}

int main() {
    //==========================================================
    // Get an unknown number of integers into array.

    size_t len = 4;
    long *buf = malloc(len * sizeof *buf);

    if(buf == NULL) {     // check for NULL        
        printf("Not enough memory to allocate.\n");
        return 1;
    }

    size_t i = 0; // record numbers of integers in array.
    long *temp; // to save buf in case realloc fails

    // read until EOF or matching failure occurs
    while(scanf("%ld",buf+i) == 1){
        i++;
        if(i == len){
            temp = buf;
            len *= 2;
            buf = realloc(buf,len * sizeof *buf);
            if (buf == NULL){
                printf("Not enough memory to reallocate.\n");
                buf = temp;
                break;
            }
        }
    }

    if(i == 0) {
        printf("No input read\n");
        return 1;
    }

    //=========================================================

    int length = i;

    // Generate a new array.
    long *buff = malloc(i * sizeof *buf);
    if(buff == NULL) {     // check for NULL        
        printf("Not enough memory to allocate.\n");
        return 1;
    }
    memcpy(buff,buf,i * sizeof *buf);

    timing(sort(buf,0,length-1));
    timing(sort(buff,0,length-1));
    return 0;
}
