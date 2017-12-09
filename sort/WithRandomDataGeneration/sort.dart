import 'dart:collection';
import 'dart:math';
import 'myList.dart';

const int INSERTSORT_THRESHOLD = 32;

void main() {
  testCreationAndUsage();
}

void testCreationAndUsage() {
  var length = 1000000;
  var src1 = new List.generate(length, (_) => new Random().nextInt(length));
  var src3 = new MyList.from(src1);
  Sort(src3);
}

InsertSort(MyList a) {
  for (var i = 1; i < a.length; i++) {
    // 依次将a[1]~a[len-1]插入到前面已排序序列
    var temp = a[i]; // 暂存a[i]
    int l = 0;
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
Sort(MyList s) {
  if (s.length <= 1) {
    return;
  }
  if (s.length <= INSERTSORT_THRESHOLD) {
    InsertSort(s);
    return;
  }
  var pivotIdx = partition(s);
  // Differentiating from java, dart's sublist is new created list.
  // User a wrapper function 'getPart' instead to avoid copying.
  Sort(s.subList(0, pivotIdx));
  Sort(s.subList(pivotIdx + 1));
  return;
}

int partition(MyList a) {
  var rIndex = new Random().nextInt(2 ^ 64 - 1) % a.length;
  // 将枢值交换到第一个元素
  swap(a, 0, rIndex);
  var pivotkey = a[0]; // 置当前表中第一个元素为枢轴值
  var i = 0;
  for (var j = 1; j < a.length; j++) {
    // 从第二个元素开始找小于基准的元素
    if (a[j] < pivotkey) {
      // 找到和交换到前面
      i++;
      swap(a, i, j);
    }
  }
// 将基准元素插入到最终位置
  swap(a, 0, i);
  return i;
}

swap(MyList a, int i, int j) {
  var temp = a[i];
  a[i] = a[j];
  a[j] = temp;
}
