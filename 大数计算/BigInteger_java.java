import java.io.*;
import java.math.BigInteger;
public class BigInteger_java {
    public static void main(String[]args){
        try{
            BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
            String a = in.readLine();
            String b = in.readLine();
            long start = System.currentTimeMillis();
            BigInteger c = new BigInteger(a);
            BigInteger d = new BigInteger(b);
            String e = c.multiply(d).toString();	
            System.out.println(e);
            long end = System.currentTimeMillis();
            System.out.println((end - start) + "ms");
        }catch (IOException e){}
    }
}
