//dart implemention
class HanoiState{
  var n,disk,x,y,z;
  HanoiState(this.n,this.disk,this.x,this.y,this.z);
}

class Stack<Item> extends Object {
  List _elem;
  
  Stack() {
    _elem = [];
  }
 
  bool get isEmpty => _elem.length == 0;
  int get length => _elem.length;
  void set setsize(size){
    _elem.length = size;
  }
 
  void push(Item item) {
    _elem.add(item);
  }
  
  Item pop() {
    if(isEmpty)
      throw("NoSuchElementException Stack underflow");
    Item item = _elem.removeLast();
    return item;
  }
}

void hanoi(n,x,y,z) {
  var count = 0;
  var stack = new Stack<HanoiState>();
  stack.setsize = 20;
  var state = new HanoiState(n, n, 'A', 'B', 'C');
  stack.push(state);
  HanoiState tmpState = null;
  while(!stack.isEmpty && (tmpState = stack.pop()) != null){
    if(tmpState.n == 1) {
      count++;
      //print('$count. move disk ${tmpState.disk} from ${tmpState.x} to ${tmpState.z}');
    }
    else{
      stack.push(new HanoiState(tmpState.n-1,tmpState.n-1,tmpState.y,tmpState.x,tmpState.z));
      stack.push(new HanoiState(1,tmpState.n,tmpState.x,tmpState.y,tmpState.z));
      stack.push(new HanoiState(tmpState.n-1,tmpState.n-1,tmpState.x,tmpState.z,tmpState.y));
    }
  }
}
void main() {
  var sw = new Stopwatch()..start();
  hanoi(25,'A','B','C');
  sw.stop();
  print('${sw.elapsedMilliseconds}ms.');
}
