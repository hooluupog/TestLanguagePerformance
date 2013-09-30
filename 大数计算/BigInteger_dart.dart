import 'dart:io';
void main() {
  var a = int.parse(stdin.readLineSync());
  var b = int.parse(stdin.readLineSync());
  var sw = new Stopwatch();
  sw.start();
  var c = a*b;
  print('$c\n');
  sw.stop();
  print('${sw.elapsedMilliseconds}ms.');
}