void main() {
  var a = new HashMap();
  for (var i = 0; i < 100000000; i++) {
    a[i & 0xffff] = i;
  }
}
