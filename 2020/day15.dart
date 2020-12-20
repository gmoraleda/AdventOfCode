main() {
  final input = [6, 4, 12, 1, 20, 0, 16];

  partOne(input);
  partTwo(input);
}

void partOne(List<int> input) {
  var spoken = List.from(input);

  for (var i = input.length; i < 2020; i++) {
    final lastSpoken = spoken.last;
    if (spoken.findOccurrences(lastSpoken) == 1) {
      spoken.add(0);
    } else {
      var lastIndex = spoken.lastIndexOf(lastSpoken);
      var previousIndex = spoken.lastIndexOf(lastSpoken, lastIndex - 1);
      spoken.add(lastIndex - previousIndex);
    }
  }
  print(spoken.last);
}

void partTwo(List<int> input) {
  var spokenArray = List<int>.from(input);
  Map<int, List<int>> spokenMap = Map.fromIterable(input,
      key: (key) => key, value: (value) => [input.indexOf(value)]);

  for (var i = input.length; i < 30000000; i++) {
    final lastSpoken = spokenArray.last;

    if (spokenMap[lastSpoken] != null && spokenMap[lastSpoken].length == 1) {
      spokenArray.add(0);
      if (spokenMap[0] != null) {
        spokenMap[0].add(i);
      } else {
        spokenMap[0] = [i];
      }
    } else {
      final appearances = spokenMap[lastSpoken];
      final age = appearances[appearances.length - 1] -
          appearances[appearances.length - 2];
      spokenArray.add(age);
      if (spokenMap[age] != null) {
        spokenMap[age].add(i);
      } else {
        spokenMap[age] = [i];
      }
    }
  }
  print(spokenArray.last);
}

extension ListExtension<T extends Comparable> on List {
  int findOccurrences(T element) {
    return this.where((item) => item == element).length;
  }
}
