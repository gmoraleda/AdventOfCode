import 'dart:io';

main() {
  var path = 'input11.txt';

  final file = new File(path);
  final input = file.readAsLinesSync().map((e) => e.split('')).toList();

  printArray(input);
  print(countSeats(input));
}

void printArray(List<List<String>> input) {
  for (var i = 0; i < input.length; i++) {
    var line = '';
    for (var j = 0; j < input.first.length; j++) {
      line += input[i][j];
    }
    print(line);
  }
}

int countSeats(List<List<String>> input) {
  return input.fold(0, (int value, element) {
    final rowCount = element.fold(
        0, (int value, element) => value += element == 'L' ? 1 : 0);
    return value + rowCount;
  });
}
