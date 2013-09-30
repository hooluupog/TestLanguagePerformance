final int SIZE = 8192;
final int NUM = 1 << 25;
void main(){
  List<int> content = new List(SIZE);
  content.fillRange(0, SIZE, 0);
  for(int i = 0; i < NUM;i++){
    if(i % SIZE == 0 && i > 0)
      print(content);
    content[i % SIZE] = i;
  }
  if (NUM % SIZE ==0)
    print(content);
  else
    print(content.sublist(0, NUM % SIZE));
}
