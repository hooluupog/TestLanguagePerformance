import java.util.ArrayList;
import java.util.List;
public class StreamTest {
 static List < Integer > myList = new ArrayList < > ();
 public static void main(String[] args) {
  for (int i = 0; i < 30000000; i++)
   myList.add(i);
  long result = 0;
  long loopStartTime = System.currentTimeMillis();
  for (int i: myList) {
   if (i % 2 == 0)
    result += i;
  }
  long loopEndTime = System.currentTimeMillis();
  System.out.println(result);
  System.out.println("Loop total Time = " + (loopEndTime - loopStartTime));
  long streamStartTime = System.currentTimeMillis();
  System.out.println(myList.stream().filter(value -> value % 2 == 0).mapToLong(Integer::longValue).sum());
  long streamEndTime = System.currentTimeMillis();
  System.out.println("Stream total Time = " + (streamEndTime - streamStartTime));
  long parallelStreamStartTime = System.currentTimeMillis();
  System.out.println(myList.parallelStream().filter(value -> value % 2 == 0).mapToLong(Integer::longValue).sum());
  long parallelStreamEndTime = System.currentTimeMillis();
  System.out.println("Parallel Stream total Time = " + (parallelStreamEndTime - parallelStreamStartTime));
 }
}
