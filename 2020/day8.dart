import 'dart:io';

main() {
  var path = './2020/input8.txt';

  final file = new File(path);
  final lines = file.readAsLinesSync();

  List<Pair<List<String>, bool>> generateList() => lines.map((e) {
        return Pair(e.split(' '), false);
      }).toList();

  final original = generateList();
  var jumps = iterateList(original);

  for (var i = 0; i < jumps.length; i++) {
    var clone = generateList();
    clone[jumps[i]].a.first = 'nop';
    iterateList(clone);
  }
}

List<int> iterateList(List<Pair<List<String>, bool>> list) {
  var acc = 0;
  var i = 0;
  var finished = false;
  var instructions = List<int>();

  while (!finished) {
    if (i >= list.length || list[i].b == true) {
      finished = true;
      break;
    }
    if (list[i].a.first == 'nop') {
      list[i].b = true;
      i++;
    } else if (list[i].a.first == 'acc') {
      acc += int.parse(list[i].a.last);
      list[i].b = true;
      i++;
    } else if (list[i].a.first == 'jmp') {
      instructions.add(i);

      list[i].b = true;
      i += int.parse(list[i].a.last);
    }
  }

  if (i == list.length) {
    print("Finished - acc: $acc");
    exit(1);
  } else {
    return instructions;
  }
}

class Pair<T1, T2> {
  T1 a;
  T2 b;

  Pair(this.a, this.b);
  @override
  String toString() {
    return "\n$a - $b";
  }
}
