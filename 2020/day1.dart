import 'dart:io';

main() {
  var path = 'input.txt';
  final file = new File(path);
  final List<int> list =
      file.readAsLinesSync().map((e) => int.parse(e)).toList();
  final map = new Map.fromIterable(list, key: (k) => k, value: (v) => 2020 - v);

  map.forEach((key, value) {
    for (var number in list) {
      if (list.contains(value - number)) {
        print('$key $number ${value - number}');
        print('${key * number * (value - number)}');
        exit(-1);
      }
    }
  });
}
