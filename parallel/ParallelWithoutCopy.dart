import 'dart:isolate';
import 'dart:async';

int sum(int LEN) {
  var res = 0;
  for (var i = 0; i < LEN; i++) {
    if (i % 2 == 0) res += i;
  }
  return res;
}

void psum(var msg) {
  int start = msg[0];
  int end = msg[1];
  SendPort replyTo = msg[2];
  int res = 0;
  for(var i = start;i < end;i++){
      if(i % 2 == 0)
          res += i;
  }
  //var res = a.where((n) => n % 2 == 0).reduce((a, b) => a + b);
  replyTo.send(res);
}

parallelSum(int LEN, int N,ReceivePort port) {
  var reply = port.sendPort;
  var offset = LEN ~/ N;
  for (var i = 0; i < N; i++) {
    Isolate.spawn(psum, [i * offset, i * offset + offset,reply]);
  }
}

main() async {
  final watch = new Stopwatch();
  int LEN = 5000000000;
  int N = 4;
  print("sum using loop");
  watch.start();
  print(sum(LEN));
  watch.stop();
  print("Elapsed time: ${watch.elapsedMilliseconds}ms");
  print("sum using parallel");
  watch..reset()..start();
  var res = 0;
  var count = 0;
  var port = new ReceivePort();
  parallelSum(LEN, N,port);
  port.listen((msg){
      res += msg;
      count++;
      if (count == N){
          print(res);
          port.close();
          watch.stop();
          print("Elapsed time: ${watch.elapsedMilliseconds}ms");
      }
  });
}
