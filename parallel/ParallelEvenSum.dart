import 'dart:isolate';
import 'dart:async';

int sum(List<int> a) {
  var res = 0;
  for (var i = 0; i < a.length; i++) {
    if (a[i] % 2 == 0) res += a[i];
  }
  return res;
}

void psum(var msg) {
  List<int> a = msg[0];
  SendPort reply = msg[1];
  int res = 0;
  for(var i = 0;i < a.length;i++){
      if(a[i] % 2 == 0)
          res += a[i];
  }
  //var res = a.where((n) => n % 2 == 0).reduce((a, b) => a + b);
  reply.send(res);
}

parallelSum(List<int> a, int N) {
  var res = 0;
  var count = 0;
  var receivePort = new ReceivePort();
  var offset = a.length ~/ N;
  final watch = new Stopwatch()..start();
  for (var i = 0; i < N; i++) {
    Isolate.spawn(psum, [a.sublist(i * offset, i * offset + offset), receivePort.sendPort]);
  }
  receivePort.listen((msg) {
    res += msg;
    count++;
    if (count == N){
        print(res);
        watch.stop();
        print("Elapsed time: ${watch.elapsedMilliseconds}ms");
        receivePort.close();
    }
  });
}

main() async {
  final watch = new Stopwatch();
  final l = new List<int>.generate(30000000, (i) => i);
  print("sum using loop");
  watch.start();
  print(sum(l));
  watch.stop();
  print("Elapsed time: ${watch.elapsedMilliseconds}ms");
  print("sum using where reduce");
  watch..reset()..start();
  print(l.where((n) => n % 2 == 0).reduce((a, b) => a + b));
  watch.stop();
  print("Elapsed time: ${watch.elapsedMilliseconds}ms");
  print("sum using parallel");
  parallelSum(l, 3);
}
