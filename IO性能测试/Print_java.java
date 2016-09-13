import java.io.*;
public class Print_java{
    public static final int NUM = 1 << 25;
    public static void main(String[]args)throws Exception {
        try{
            PrintWriter out = new PrintWriter(System.out);
            for(int i = 0;i < NUM; i++){
                out.println(i);
            }
            out.close();
        }catch(Exception e){}
    }
}
