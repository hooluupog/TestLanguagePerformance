import 'dart:io';
import 'dart:math';
import 'dart:convert';

const int INSERTSORT_THRESHOLD = 32;

swap(List a, int i, int j) {
  var temp = a[i];
  a[i] = a[j];
  a[j] = temp;
}

InsertSort(List a, int start, int end) {
  for (var i = start + 1; i <= end; i++) {
    // 依次将a[1]~a[len-1]插入到前面已排序序列
    var temp = a[i]; // 暂存a[i]
    int l = start;
    int h = i - 1; // 设置折半查找范围
    while (l <= h) {
      // 开始折半查找(升序)
      var mid = (l + h) ~/ 2; // 取中间点
      if (a[mid] > temp) {
        // 查找左半子表
        h = mid - 1;
      } else {
        // 查找右半子表
        l = mid + 1;
      }
    }
    for (var j = i - 1; j >= h + 1; j--) {
      // 统一后移元素，空出插入位置
      a[j + 1] = a[j];
    }
    a[h + 1] = temp; // 插入操作
  }
}

// Classic quicksort.
Sort(List s, int start, int end) {
  int length = end - start + 1;
  if (length <= 1) {
    return;
  }
  if (length <= INSERTSORT_THRESHOLD) {
    InsertSort(s, start, end);
    return;
  }
  var pivotIdx = partition(s, start, end);
  Sort(s, start, pivotIdx - 1);
  Sort(s, pivotIdx + 1, end);
  return;
}

int partition(List a, int start, int end) {
  int length = end - start + 1;
  var rIndex = start + new Random().nextInt(2 ^ 64 - 1) % length;
  // 将枢值交换到第一个元素
  swap(a, start, rIndex);
  var pivotkey = a[start]; // 置当前表中第一个元素为枢轴值
  var i = start;
  for (var j = start + 1; j <= end; j++) {
    // 从第二个元素开始找小于基准的元素
    if (a[j] < pivotkey) {
      // 找到和交换到前面
      i++;
      swap(a, i, j);
    }
  }
// 将基准元素插入到最终位置
  swap(a, start, i);
  return i;
}

void measure(String text, f()) {
  var sw = new Stopwatch();
  sw.start();
  f();
  sw.stop();
  var time = sw.elapsedMilliseconds;
  print("$text: $time ms.");
}

main() async {
  var l = new List<int>();
  var s = (await stdin.transform(ASCII.decoder).toList())
      .join()
      .trim()
      .split(new RegExp(r'[\n\r\n\s+]+'));
  s.forEach((i) => l.add(int.parse(i)));
  var ll = new List.from(l);
  measure('time used', () => l.sort());
  //ll.sort((b,a) => a.compareTo(b));
  measure('time used', () => Sort(ll, 0, ll.length - 1));
}
