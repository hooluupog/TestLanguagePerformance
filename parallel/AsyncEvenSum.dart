import 'dart:async';

var result;

int sum(List<int> a) {
  var res = 0;
  for (var i = 0; i < a.length; i++) {
    if (a[i] % 2 == 0) res += a[i];
  }
  result = res;
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
  result = res;
}

void measure(String text, f()) {
  var sw = new Stopwatch();
  sw.start();
  f();
  sw.stop();
  var time = sw.elapsedMilliseconds;
  print("$text: $time ms.");
}

void measureAsync(String text, f()) async {
  var sw = new Stopwatch();
  sw.start();
  await f();
  sw.stop();
  var time = sw.elapsedMilliseconds;
  print("$text: $time ms.");
}

main() {
  final l = new List<int>.generate(30000000, (i) => i);
  measure('sum using loop',() => sum(l));
  measure('sum using where reduce',() => 
          l.where((n) => n % 2 == 0).reduce((a, b) => a + b));
  measureAsync('sum using Asynchronous',() => totalSum(l, 100));
}
