import 'dart:isolate';
import 'MList.dart';

var result;

int sum(MList<int> a) {
  var res = 0;
  for (var i = 0; i < a.length; i++) {
    if (a[i] % 2 == 0) res += a[i];
  }
  result = res;
  return res;
}

void psum(var msg) {
  MList<int> a = msg[0];
  SendPort reply = msg[1];
  int res = 0;
  for (var i = 0; i < a.length; i++) {
    if (a[i] % 2 == 0) res += a[i];
  }
  //var res = a.where((n) => n % 2 == 0).reduce((a, b) => a + b);
  reply.send(res);
}

parallelSum(MList<int> a, int N) {
  var sw = new Stopwatch()..start();
  var res = 0;
  var count = 0;
  var receivePort = new ReceivePort();
  var offset = a.length ~/ N;
  for (var i = 0; i < N; i++) {
    // Spawn does not support transferable objects presently,
    // it has to copy list a and then transfer it to other isolates.
    // Also,List's sublist should also be avoided because sublist function
    // will do a shallow copy from origin list.In this program,A custom
    // implemented MList with subList method(zero-copy,backed by origin
    // list) being used here. Once transferable data is supported by
    // isolate, the copying would be completely avoided.
    Isolate.spawn(psum,
        [a.subList(i * offset, i * offset + offset), receivePort.sendPort]);
  }
  receivePort.listen((msg) {
    res += msg;
    count++;
    if (count == N) {
      result = res;
      sw.stop();
      print('sum using parallel: ${sw.elapsedMilliseconds}ms.');
      receivePort.close();
    }
  });
}

void measure(String text, f()) {
  var sw = new Stopwatch();
  sw.start();
  f();
  sw.stop();
  var time = sw.elapsedMilliseconds;
  print("$text: ${time}ms.");
}

main() async {
  final l = new List<int>.generate(30000000, (i) => i);
  var ll = new MList.from(l);
  measure('sum using loop', () => sum(ll));
  measure('sum using where reduce',
      () => ll.where((n) => n % 2 == 0).reduce((a, b) => a + b));
  parallelSum(ll, 3);
}
