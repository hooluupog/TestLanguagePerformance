import java.util.Stack;
public class Hanoi_stack_java{
        //用栈模拟递归汉诺塔
	public void hanoi(int n){
		int count = 0;
		Stack<Hanoi_state> stack = new Stack<Hanoi_state>();
		stack.setSize(20);//预分配栈容量
		Hanoi_state state = new Hanoi_state(n,n,'A','B','C');
		stack.push(state);
		Hanoi_state tmpState = null;
		while((!stack.isEmpty()) && (tmpState = stack.pop()) != null){
			if(tmpState.num == 1){
				count++;
			//	System.out.println(count + ".move disk " + tmpState.disk + " from " + tmpState.src + " to " + tmpState.des);
			}
			else{
				stack.push(new Hanoi_state(tmpState.num-1,tmpState.num-1,tmpState.tmp,tmpState.src,tmpState.des));
				stack.push(new Hanoi_state(1,tmpState.num,tmpState.src,tmpState.tmp,tmpState.des));
				stack.push(new Hanoi_state(tmpState.num-1,tmpState.num-1,tmpState.src,tmpState.des,tmpState.tmp));
			}
		}
	}
	public static void main(String[]args){

		long start = System.currentTimeMillis();
		Hanoi_stack_java hanoi = new Hanoi_stack_java();
		hanoi.hanoi(25);
		long end = System.currentTimeMillis();
		System.out.println((end - start) + "ms");
	}
}
class Hanoi_state{
	public char src;
	public char des;
	public char tmp;
	public int num;//盘子数目
	public int disk;//当前移动的盘号

	public Hanoi_state(int num,int disk,char src,char tmp,char des){
		this.num = num;
		this.disk = disk;
		this.src = src;
		this.des = des;
		this.tmp = tmp;
	}
}
