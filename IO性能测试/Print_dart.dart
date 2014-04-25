import 'dart:io';

final int NUM = 1 << 25;
void test(n){
  //var out  = new File('a.out').openSync(mode: WRITE);
  for(int i = 0; i < n;i++){
    stdout.write(i); //stdout write is async, non blocking.
    //print(i);// print is sync.
    //out.writeStringSync(i.toString());
  }
  //out.close();
  stdout.close();
}

void main(){
  //warm up vm
  test(1);
  var sw = new Stopwatch()..start();
  //the test
  test(NUM);
  sw.stop();
  print('${sw.elapsedMilliseconds} ms.');
}
