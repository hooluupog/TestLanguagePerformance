import java.io.*;
public class Print_java{
    public static void main(String[]args)throws Exception {
        try{
            PrintWriter out = new PrintWriter(System.out);
            for(int i = 0;i < 1 << 25; i++){
                out.print(i);
            }
            out.close();
        }catch(Exception e){}
    }
}
