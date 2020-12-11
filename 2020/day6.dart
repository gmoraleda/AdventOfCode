import 'dart:io';

main() {
  var path = './2020/input6.txt';

  final file = new File(path);
  final string = file.readAsStringSync();

  final groups = string.split('\n\n');

  // Part 1
  var part1Count = 0;
  groups.forEach((element) {
    var set = new Set();

    element.replaceAll('\n', '').split('').forEach((element) {
      set.add(element);
    });
    part1Count += set.length;
  });
  print(part1Count);

  // Part 2

  var part2count = 0;
  groups.forEach((element) {
    var answers = element.split('\n');
    var groupSize = answers.length;
    var map = new Map<String, int>();

    answers.forEach((element) {
      element.split('').forEach((element) {
        if (map[element] != null) {
          map[element]++;
        } else {
          map[element] = 1;
        }
      });
    });

    map.forEach((key, value) {
      if (value == groupSize) {
        part2count++;
      }
    });
  });
  print(part2count);
}
