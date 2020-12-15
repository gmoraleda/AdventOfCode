import 'dart:io';
import 'dart:math';

main() {
  var path = 'input5.txt';

  final file = new File(path);
  final List<String> list = file.readAsLinesSync();

  var ids = list.map((e) {
    final rowId = row(e.substring(0, 7));
    final columnId = column(e.substring(7, 10));

    return rowId * 8 + columnId;
  }).toList();

  // part 1
  print(ids.reduce(max));

  // part 2
  ids.sort();
  for (var id in ids) {
    if (!ids.contains(id + 1)) {
      print(id + 1);
      break;
    }
  }
}

int row(String str) {
  var list = Iterable<int>.generate(128).toList();
  var splitted = str.split('');

  for (var i = 0; i < splitted.length - 1; i++) {
    if (splitted[i] == 'F') {
      list = list.sublist(0, (list.length ~/ 2));
    } else {
      list = list.sublist((list.length ~/ 2));
    }
  }

  return str[str.length - 1] == 'F' ? list[0] : list[list.length - 1];
}

int column(String str) {
  var list = Iterable<int>.generate(8).toList();
  var splitted = str.split('');

  for (var i = 0; i < splitted.length - 1; i++) {
    if (splitted[i] == 'L') {
      list = list.sublist(0, (list.length ~/ 2));
    } else {
      list = list.sublist((list.length ~/ 2));
    }
  }

  return str[str.length - 1] == 'L' ? list[0] : list[list.length - 1];
}
