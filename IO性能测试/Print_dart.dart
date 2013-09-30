import 'dart:io';

final int NUM = 1 << 25;
void main(){
  for(int i = 0; i < NUM;i++){
    stdout.write(i);
  }
}
