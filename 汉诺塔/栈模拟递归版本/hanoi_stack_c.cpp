#include "stdio.h"
#include "stdlib.h"
#include "sys/time.h"
typedef int ElemType;
typedef int Status;

#define OK 1
#define ERROR 0
#define EMPTY_STACK_TOP -1
#define OWERFLOW -2
#define STACK_SIZE 100
typedef struct Stack{
    ElemType top;  //栈顶游标
    ElemType data[STACK_SIZE]; //栈数据
    char x[STACK_SIZE];
    char y[STACK_SIZE];
    char z[STACK_SIZE];
    int  n[STACK_SIZE];
}*SqStack;

Status InitStack(SqStack &s);//栈初始化
Status Push(SqStack s,ElemType e,int n,char x,char y,char z);//入栈
Status Pop(SqStack s,ElemType &e,int &n,char &x,char &y,char &z);//出栈
Status IsEmpty(SqStack s);

Status InitStack(SqStack &s)
    //栈初始化
{
    s = (SqStack)malloc(sizeof(Stack));
    if(!s) exit(OWERFLOW);
    s->top = EMPTY_STACK_TOP;
    return OK;
}

Status Push(SqStack s,ElemType e,int n,char x,char y,char z)
    //入栈
{
    if(s->top == STACK_SIZE-1) return ERROR;//栈满
    else {
        s->top++;
        s->data[s->top] = e; //插入新的元素
        s->n[s->top] = n;
        s->x[s->top] = x;
        s->y[s->top] = y;
        s->z[s->top] = z;
    }
    return OK;
}
Status Pop(SqStack s,ElemType &e,int &n,char &x,char &y,char &z)
    //出栈
{
    if(s->top == -1) return ERROR;//栈空
    else{
        e = s->data[s->top];
        n = s->n[s->top];
        x = s->x[s->top];
        y = s->y[s->top];
        z = s->z[s->top];
        s->top--;
    }
    return OK;
}

Status IsEmpty(SqStack s)
{
    if(s->top == -1) return 1;
    else return 0;
}

/*汉诺塔递归版本
 * 将塔座x上按直径有小到大且自上而下编号为1至n的n个圆盘按规则搬到塔座z，y作为辅助
 * 盘，其中直径大的盘不能放在直径小的盘子上,每次只能移动一个盘
 * int count = 0; //全局变量，对搬动计数
 *	void hanoi(int n,char x,char y,char z)
 *	{
 *		if(n == 1)
 *			printf("%d. Move disk %d from %c to %c\n",++count,n,x,z);
 *		else{
 *			hanoi(n-1,x,z,y);
 *			printf("%d. Move disk %d from %c to %c\n",++count,n,x,z);
 *			hanoi(n-1,y,x,z);
 *		}
 *	}
 */

int count = 0; //全局变量，对搬动计数
void hanoi(int n,char x,char y,char z){
    //栈模拟汉诺塔递归算法
    SqStack A;
    int disk;
    InitStack(A);
    Push(A,n,n,x,y,z);
    //模拟递归开始
    while(!IsEmpty(A))
    {
        Pop(A,n,disk,x,y,z);
        if(n == 1) //n=1，模拟递归出口，disk记录要移动的盘号
            count++;
        //printf("%d. Move disk %d from %c to %c\n",++count,disk,x,z);
        else{
            //注意栈的压入顺序和递归函数的调用是正好相反的
            Push(A,n-1,n-1,y,x,z);
            Push(A,1,n,x,y,z);
            Push(A,n-1,n-1,x,z,y);
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
