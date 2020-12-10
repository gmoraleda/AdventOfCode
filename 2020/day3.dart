import 'dart:io';

main() {
  var path = './2020/input3.txt';

  final file = new File(path);
  final List<String> list = file.readAsLinesSync();

  int checkSlope(int dx, int dy) {
    var trees = 0;
    var x = 0;
    var y = 0;
    var rowLength = list[0].length;

    while (y < list.length - 1) {
      y += dy;
      x = (x + dx) % rowLength;
      if (list[y][x] != null) {
        trees += list[y][x] == '#' ? 1 : 0;
      }
    }
    return trees;
  }

  print(checkSlope(1, 1) *
      checkSlope(3, 1) *
      checkSlope(5, 1) *
      checkSlope(7, 1) *
      checkSlope(1, 2));
}
