import 'dart:io';

final int SIZE = 8192;
final int NUM = 1 << 25;
void main(){
  //var out  = new File('a.out').openSync(mode: WRITE);
  List<int> content = new List(SIZE);
  content.fillRange(0, SIZE, 0);
  for(int i = 0; i < NUM;i++){
    if(i % SIZE == 0 && i > 0)
      stdout.write(content);
      //out.writeStringSync(content.toString());
    content[i % SIZE] = i;
  }
  if (NUM % SIZE ==0)
    stdout.write(content);
    //out.writeStringSync(content.toString());
  else
    stdout.write(content.sublist(0, NUM % SIZE));
    //out.writeStringSync(content.sublist(0, NUM % SIZE).toString());
  //out.close();
  stdout.close();
}
