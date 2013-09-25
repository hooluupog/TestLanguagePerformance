import java.io.*;

public class Hanoi_java
{
    static int count  = 0;
    public static void hanoi(int n,char x, char y, char z)
    {
        if(n == 1){
            count++;
        }
        else{
            hanoi(n-1,x,z,y);
            count++;
            hanoi(n-1,y,x,z);
        }
    }
    public static void main(String[]args)
    {
        long start = System.currentTimeMillis();
        hanoi(25,'A','B','C');
        long end = System.currentTimeMillis();
        System.out.println((end - start) + "ms");
    }
}
