import java.io.*;
public class Print_java{
    public static void main(String[]args)throws Exception {
        try{
            BufferedWriter out = new BufferedWriter(new OutputStreamWriter(System.out));
            for(int i = 0;i < 1 << 25; i++){
                out.write(i);
                out.write("\n");
            }
            out.flush();
        }catch(Exception e){}
    }
}
