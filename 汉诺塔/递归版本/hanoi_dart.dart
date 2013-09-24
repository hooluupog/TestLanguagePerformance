
//var count = 0;
void hanoi(n,x,y,z) {
  if (n == 1){
    //count++;
    //print('$count. move disk $n from $x to $z');
  }
  else{
    hanoi(n-1,x,z,y);
    //count++;
    //print('$count. move disk $n from $x to $z');
    hanoi(n-1,y,x,z);
  }
}
void main() {
  var start = new DateTime.now().millisecondsSinceEpoch;
  hanoi(25,'A','B','C');
  var end = new DateTime.now().millisecondsSinceEpoch;
  print('${end - start}ms.');
}