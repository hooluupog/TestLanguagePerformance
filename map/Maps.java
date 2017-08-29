import java.util.Map;
import java.util.HashMap;

public class Maps{
    public static void  main(String[]args){
        Map<Integer,Integer> a = new HashMap<Integer,Integer>();
        for (int i = 0; i < 100000000; i++){
            a.put(new Integer(i&0xffff),new Integer(i));
        }
    }
}
