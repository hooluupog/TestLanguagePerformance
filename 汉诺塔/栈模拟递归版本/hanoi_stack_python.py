import datetime
count = 0
#栈模拟递归汉诺塔
def hanoi(n,x,y,z):
	stack = [{0,0,0,0,0}]
	elements = [n,n,x,y,z]
	stack.append(elements)    #variable stack is a List datastruct used as Stack
	global count     #声明调用的是全局变量count，而创建的非临时变量
	while len(stack) != 1:
		elem = elements = stack.pop()
		if(elements[0] == 1):
			count = count + 1
			#print "%d.move disk %d from %s to %s" %(count,elements[1],elements[2],elements[4]) 
		else:
			elements = [elem[0]-1,elem[1]-1,elem[3],elem[2],elem[4]]
			stack.append(elements)
			elements = [1,elem[1],elem[2],elem[3],elem[4]]
			stack.append(elements)
			elements = [elem[0]-1,elem[1]-1,elem[2],elem[4],elem[3]]
			stack.append(elements)
if __name__ == "__main__":
	start = datetime.datetime.now()
	hanoi(25,'A','B','C')
	duration = datetime.datetime.now() - start
	print "%f%s" %(duration.total_seconds()*1000,"ms")
