import 'dart:io';

main() {
  var path = './2020/input7.txt';

  final file = new File(path);
  final lines = file.readAsLinesSync();

  var regex = RegExp(r"(\w+\s\w+)(?=\s+bag)");

  var map = Map<String, List<String>>();

  for (var line in lines) {
    var matches = regex.allMatches(line).map((e) => e.group(0)).toList();
    map[matches.first] = matches.sublist(1).toList();
  }

  // Part 1
  var masterBags = Set<String>();
  void lookFor(String bag) {
    var keyList = map.keys.where((key) => map[key].contains(bag)).toList();

    if (keyList.isNotEmpty) {
      masterBags.addAll(keyList);
      keyList.forEach(lookFor);
    }
  }

  lookFor('shiny gold');
  print(masterBags.length);

  // Part 2
  regex = RegExp(r"(\d{0,}\s?\w+\s\w+)(?=\s+bag)");
  var mapB = Map<String, List<Pair<int, String>>>();
  for (var line in lines) {
    var matches = regex.allMatches(line).map((e) => e.group(0)).toList();
    var content = matches.sublist(1).map((e) {
      if (!e.contains('other')) {
        return Pair(int.parse(e.split(' ').first),
            e.split('').sublist(1).join().trim());
      } else {
        return null;
      }
    }).toList();
    content.removeWhere((value) => value == null);
    mapB[matches.first] = content;
  }
  var count = 0;
  void findBags(String bag) {
    if (mapB.keys.contains(bag) == false || mapB[bag].isEmpty) {
      return;
    } else {
      mapB[bag].forEach((element) {
        count += element.a;
        for (var i = 0; i < element.a; i++) {
          findBags(element.b);
        }
      });
    }
  }

  // print(mapPartTwo);
  findBags('shiny gold');
  print(count);
}

class Pair<T1, T2> {
  final T1 a;
  final T2 b;

  Pair(this.a, this.b);
  @override
  String toString() {
    return "\n$a - $b";
  }
}
