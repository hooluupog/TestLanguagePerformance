import 'dart:async';

int sum(List<int> a) {
  var res = 0;
  for (var i = 0; i < a.length; i++) {
    if (a[i] % 2 == 0) res += a[i];
  }
  return res;
}

Future<int> asum(List<int> a, int start, int end) async {
  var res = 0;
  for (var i = start; i < end; i++) {
    if (a[i] % 2 == 0) res += a[i];
  }
 //var res = a.where((n) => n % 2 == 0).reduce((a, b) => a + b);
  return res;
}

void totalSum(List<int> a, int N) async {
  var futures = [];
  int res = 0;
  var offset = a.length ~/ N;
  for (var i = 0; i < N; i++) {
    futures.add(asum(a, i * offset, i * offset + offset));
  }
  var list = await Future.wait(futures);
  list.forEach((i) => res += i);
  print(res);
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
  print("Asynchronous sum");
  watch..reset()..start();
  await totalSum(l, 100);
  watch.stop();
  print("Elapsed time: ${watch.elapsedMilliseconds}ms");
}
