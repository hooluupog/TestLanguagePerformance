/** ��������hanoi_stack_go1.go��hanoi_stack_go2.go���Ķ࣬ԭ���Ǹ���ĺ�����
** �ô����ʹ����ṹ�����ݴ������������Ǹ���ķô��������cpu�нϳ��Ŀ��еȴ�ʱ�䡣
** (1).hannoi_stack.goʹ��interface{}�����ⲿ���ݣ���push�����У�
** s.top = &Element{value, s.top}ÿ�ζ��ᴴ��һ���µ�element����Ҫ�ô濪�ٿռ䣻
** (2).hanoi()�����ڲ���
**                hs = &HanoiState{tmp.n-1,tmp.n-1,tmp.y,tmp.x,tmp.z}
**                stack.Push(hs)
** ÿ�ζ��ᴴ��һ���µ�HanoiState����Ҫ�ô濪�ٿռ䣬Ȼ�󽫸��·���Ŀռ��ַ��ջ��
** ������Ƶ���ķô浼���˳�������ܽ��͡�,ͬ����ȵݹ�汾��ʵ�֣�һ��ѭ�����ڣ�
** ��Ҫ����1��pop()��3��push()����ĺ�������Ҳ�����ӷô����(ϵͳ�Ὣ�������׵�ַ
** �ͷ��ص�ַ����ز�������ջ����)���������½���
** (3). �ڴ���Ƭ��elseѭ�����ڲ�����������д��������
** hs = &HanoiState{tmp.n-1,tmp.n-1,tmp.y,tmp.x,tmp.z}
** stack.Push(hs)
** ...
** hsΪָ�룬ÿ�λᴴ��һ���µ�hanoistate��Ȼ��hsָ�������ַ��
** 
** hs = HanoiState{tmp.n-1,tmp.n-1,tmp.y,tmp.x,tmp.z}
** stack.Push(&hs)
** ...
** hsΪһ���ṹ�����ݣ��ڳ�ʼ��ʱ�ռ�͵�ַ�Ѿ�������ˣ�hanoistate{...}Ϊһ����ʱ������
** �ṹ����ֵ�ᴫ��hs�����Ժ��ѭ���в����ٿ����µ��ڴ�ռ䣬����һֱʹ�������ʱ�ռ䣬
** ���ԣ�hs�ĵ�ַʼ���ǲ���ġ�
** ��Ȼ�������д���ô�Ĵ������١�
**/

package main

import (
	"fmt"
	"time"
)

type Stack struct {
	top  *Element
	size int
}
type Element struct {
	value interface{}
	next  *Element
}

func (s *Stack) Length() int {
	return s.size
}
func (s *Stack) Push(value interface{}) {
	//ջ��ָ��topָ���´�����element��element��value
	//�����ⲿ��ֵ���ַ(the pointer or value wrappered in interface{})
	//nextָ�뱣����һ��ջ��ָ���λ��
	s.top = &Element{value, s.top}
	s.size++
}
func (s *Stack) Pop() (value interface{}) {
	if s.size > 0 {
		value, s.top = s.top.value, s.top.next
		s.size--
		return
	}
	return nil
}

type HanoiState struct {
	n, disk int
	x, y, z byte
}

func hanoi(n int, x byte, y byte, z byte) {
	var count int = 0
	stack := new(Stack)
	hs := &HanoiState{n, n, x, y, z}
	tmp := *hs
	stack.Push(hs)
	for stack.Length() > 0 {
		hs = stack.Pop().(*HanoiState) //type assertion
		tmp = *hs
		if hs.n == 1 {
			count++
			//fmt.Printf("%d. Move disk %d from %c to %c\n", count, hs.disk,hs.x,hs.z)
		} else {
			//�ο��ݹ�汾��ʵ�֣������˳��͵ݹ麯������ǡ���෴��
			hs = &HanoiState{tmp.n - 1, tmp.n - 1, tmp.y, tmp.x, tmp.z}
			stack.Push(hs)
			hs = &HanoiState{1, tmp.n, tmp.x, tmp.y, tmp.z}
			stack.Push(hs)
			hs = &HanoiState{tmp.n - 1, tmp.n - 1, tmp.x, tmp.z, tmp.y}
			stack.Push(hs)
		}
	}
}

func main() {
	start := time.Now()
	hanoi(25, 'A', 'B', 'C')
	duration := time.Since(start)
	fmt.Printf(" %vms\n", duration.Seconds()*1000)
}
