import java.util.Arrays;
public class Print_java{
	public static final int SIZE = 8192;
	public static final int NUM = 1 << 25;
	public static void main(String[]args)throws Exception {
        try{
        	int[] buf = new int[SIZE];
        	for(int i = 0;i < NUM; i++){
                if(i % SIZE == 0 && i > 0)
                	System.out.print(Arrays.toString(buf));
                buf[i % SIZE] = i;              
            }
        	if(NUM % SIZE == 0)
        		System.out.print(Arrays.toString(buf));
        	else
        	{
        		int[] newbuf = new int[NUM % SIZE];
        		newbuf = Arrays.copyOfRange(buf, 0, (NUM % SIZE));
        		System.out.print(Arrays.toString(newbuf));
        	}
        }catch(Exception e){}
    }
}
