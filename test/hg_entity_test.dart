void main() {
  List<int> a = [1, 2, 3, 4, 5];
  int count = a.length;
  int maxNum = 3;
  a.removeRange(maxNum, count);
  print(a.join(","));
}
