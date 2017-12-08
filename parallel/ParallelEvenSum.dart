import 'dart:isolate';

var result;

int sum(List<int> a) {
  var res = 0;
  for (var i = 0; i < a.length; i++) {
    if (a[i] % 2 == 0) res += a[i];
  }
  result = res;
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
  var sw = new Stopwatch()..start();
  var res = 0;
  var count = 0;
  var receivePort = new ReceivePort();
  var offset = a.length ~/ N;
  for (var i = 0; i < N; i++) {
      // Spawn does not support transferable objects presently, 
      // it has to copy list a and then transfer it to other isolates.
      // Also,sublist should also be avoided using here because sublist
      //  function will do a shallow copy from origin list.
      // Once transferable data is supported by isolate, changing to use
      //  ByteBuffer to storage data and use typed_data.view to get subdata
      //  for sending to fully avoid copying.
    Isolate.spawn(psum, [a.sublist(i * offset, i * offset + offset), receivePort.sendPort]);
  }
  receivePort.listen((msg) {
    res += msg;
    count++;
    if (count == N){
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
  measure('sum using loop',() => sum(l));
  measure('sum using where reduce',() => 
          l.where((n) => n % 2 == 0).reduce((a, b) => a + b));
  parallelSum(l, 3);
}
