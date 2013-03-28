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
	ElemType top;  //ջ���α�
	ElemType data[STACK_SIZE]; //ջ����
	char x[STACK_SIZE];
	char y[STACK_SIZE];
	char z[STACK_SIZE];
	int  n[STACK_SIZE];
}*SqStack;

Status InitStack(SqStack &s);//ջ��ʼ��
Status Push(SqStack s,ElemType e,int n,char x,char y,char z);//��ջ
Status Pop(SqStack s,ElemType &e,int &n,char &x,char &y,char &z);//��ջ
Status IsEmpty(SqStack s);

Status InitStack(SqStack &s)
	//ջ��ʼ��
{
	s = (SqStack)malloc(sizeof(Stack));
	if(!s) exit(OWERFLOW);
	s->top = EMPTY_STACK_TOP;
	return OK;
}

Status Push(SqStack s,ElemType e,int n,char x,char y,char z)
	//��ջ
{
	if(s->top == STACK_SIZE-1) return ERROR;//ջ��
	else {
		s->top++;
		s->data[s->top] = e; //�����µ�Ԫ��
		s->n[s->top] = n;
		s->x[s->top] = x;
		s->y[s->top] = y;
		s->z[s->top] = z;
	}
	return OK;
}
Status Pop(SqStack s,ElemType &e,int &n,char &x,char &y,char &z)
	//��ջ
{
	if(s->top == -1) return ERROR;//ջ��
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

/*��ŵ���ݹ�汾
 * ������x�ϰ�ֱ����С���������϶��±��Ϊ1��n��n��Բ�̰�����ᵽ����z��y��Ϊ����
 * �̣�����ֱ������̲��ܷ���ֱ��С��������,ÿ��ֻ���ƶ�һ����
 * int count = 0; //ȫ�ֱ������԰ᶯ����
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

int count = 0; //ȫ�ֱ������԰ᶯ����
void hanoi(int n,char x,char y,char z){
	//ջģ�⺺ŵ���ݹ��㷨
	SqStack A;
	int disk;
	InitStack(A);
	Push(A,n,n,x,y,z);
	//ģ��ݹ鿪ʼ
	while(!IsEmpty(A))
	{
		Pop(A,n,disk,x,y,z);
		if(n == 1) //n=1��ģ��ݹ���ڣ�disk��¼Ҫ�ƶ����̺�
			count++;
			//printf("%d. Move disk %d from %c to %c\n",++count,disk,x,z);
		else{
			//ע��ջ��ѹ��˳��͵ݹ麯���ĵ����������෴��
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




