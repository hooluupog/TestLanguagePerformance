int count(List<int> a) {
  int N = a.length;
  int cnt = 0;
  for (int i = 0; i < N; i++) {
    for (int j = i + 1; j < N; j++) {
      for (int k = j + 1; k < N; k++) {
        if (a[i] + a[j] + a[k] == 0) {
          cnt++;
        }
      }
    }
  }
  return cnt;
}
int timeTrial(int N) {
  var a = new List<int>(N);
  for (int i = 0; i < N; i++) {
    a[i] = i + 1;
  }
  return count(a);
}

void main() {
  int res;
  res = timeTrial(250);
  res = timeTrial(500);
  res = timeTrial(1000);
  res = timeTrial(2000);
}
