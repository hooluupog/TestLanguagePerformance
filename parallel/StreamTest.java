import java.util.ArrayList;
import java.util.List;
public class StreamTest {
    private static long res;

    public static void measure(String text, Runnable runnable) {
        long start = System.currentTimeMillis();
        runnable.run();
        long end = System.currentTimeMillis();
        System.out.println(String.format("%s: %dms.",text, end - start));
    }

    static List < Integer > myList = new ArrayList < > ();
    public static void main(String[] args) {
        for (int i = 0; i < 30000000; i++)
            myList.add(i);
        measure("sum using loop",()-> {
            long result = 0;
            for (int i : myList) {
                if (i % 2 == 0)
                    result += i;
            }
            res = result;
        });
        measure("sum using stream",() -> myList.stream().
                filter(value -> value % 2 == 0).mapToLong(Integer::longValue).sum());
        measure("sum using parallel stream",() -> myList.parallelStream().
                filter(value -> value % 2 == 0).mapToLong(Integer::longValue).sum());
    }
}
