import 'dart:io';

main() {
  var path = './2020/input7.txt';

  final file = new File(path);
  final lines = file.readAsLinesSync();

  var regex = RegExp(r"(\w+\s\w+)(?=\s+bag)");

  var mapPartOne = Map<String, List<String>>();

  for (var line in lines) {
    var matches = regex.allMatches(line).map((e) => e.group(0)).toList();
    mapPartOne[matches.first] = matches.sublist(1).toList();
  }

  // Part 1
  var parentBags = Set<String>();
  void lookFor(String bag) {
    var keyList =
        mapPartOne.keys.where((key) => mapPartOne[key].contains(bag)).toList();

    if (keyList.isNotEmpty) {
      parentBags.addAll(keyList);
      keyList.forEach(lookFor);
    }
  }

  lookFor('shiny gold');
  print(parentBags.length);

  // Part 2
  regex = RegExp(r"(\d{0,}\s?\w+\s\w+)(?=\s+bag)");
  var mapPartTwo = Map<String, List<Pair<int, String>>>();
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
    mapPartTwo[matches.first] = content;
  }
  var childCount = 0;
  void findBags(String bag) {
    if (mapPartTwo.keys.contains(bag) == false || mapPartTwo[bag].isEmpty) {
      return;
    } else {
      mapPartTwo[bag].forEach((element) {
        childCount += element.n;
        for (var i = 0; i < element.n; i++) {
          findBags(element.color);
        }
      });
    }
  }

  findBags('shiny gold');
  print(childCount);
}

class Pair<T1, T2> {
  final T1 n;
  final T2 color;

  Pair(this.n, this.color);
  @override
  String toString() {
    return "\n$n - $color";
  }
}
