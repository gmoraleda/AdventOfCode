main() {
  final input = [6, 4, 12, 1, 20, 0, 16];
  var spoken = List.from(input);

  partOne(input, spoken);
}

void partOne(List<int> input, List spoken) {
  for (var i = input.length; i < 30000000; i++) {
    final lastSpoken = spoken.last;
    if (spoken.findOccurrences(lastSpoken) == 1) {
      spoken.add(0);
    } else {
      var lastIndex = spoken.lastIndexOf(lastSpoken);
      var previousIndex = spoken.lastIndexOf(lastSpoken, lastIndex - 1);
      lastIndex++;
      previousIndex++;
      spoken.add(lastIndex - previousIndex);
    }
  }
  print(spoken.last);
}

extension ListExtension<T extends Comparable> on List {
  int findOccurrences(T element) {
    return this.where((item) => item == element).length;
  }
}
