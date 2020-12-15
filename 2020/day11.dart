import 'dart:io';

main() {
  var path = 'input11.txt';

  final file = new File(path);
  final input = file.readAsLinesSync().map((e) => e.split('')).toList();

  var output = update(input);

  while (true) {
    var temp = update(output);
    output = temp;
    print('${countSeats(output)}');
  }
}

List<List<String>> update(List<List<String>> input) {
  final List<List<String>> copy =
      input.map((element) => List<String>.from(element)).toList();

  for (var i = 0; i < input.length; i++) {
    for (var j = 0; j < input.first.length; j++) {
      switch (input[i][j]) {
        case '.':
          copy[i][j] = '.';
          continue;
        case 'L':
          copy[i][j] = sit(input, i, j, "L");
          continue;
        case '#':
          copy[i][j] = sit(input, i, j, "#");
          continue;
      }
    }
  }
  return copy;
}

String sit(List<List<String>> input, int i, int j, String mode) {
  var count = 0;
  var sit = true;

  // Right
  if (input.tryGet(i, j + 1) != null && input[i][j + 1] == '#') {
    count++;
    sit = false;
  }
  // Left
  if (input.tryGet(i, j - 1) != null && input[i][j - 1] == '#') {
    count++;
    sit = false;
  }
  // Up
  if (input.tryGet(i - 1, j) != null && input[i - 1][j] == '#') {
    count++;
    sit = false;
  }
  // Down
  if (input.tryGet(i + 1, j) != null && input[i + 1][j] == '#') {
    count++;
    sit = false;
  }
  // Up-Right
  if (input.tryGet(i - 1, j + 1) != null && input[i - 1][j + 1] == '#') {
    count++;
    sit = false;
  }
  // Up-Left
  if (input.tryGet(i - 1, j - 1) != null && input[i - 1][j - 1] == '#') {
    count++;
    sit = false;
  }
  // Down-Right
  if (input.tryGet(i + 1, j + 1) != null && input[i + 1][j + 1] == '#') {
    count++;
    sit = false;
  }
  // Down-Left
  if (input.tryGet(i + 1, j - 1) != null && input[i + 1][j - 1] == '#') {
    count++;
    sit = false;
  }

  if (mode == "#") {
    if (count >= 4) {
      return 'L';
    } else if (input[i][j] == '.') {
      return '.';
    }
    return '#';
  } else {
    if (sit) {
      return '#';
    } else if (input[i][j] == '.') {
      return '.';
    }
    return 'L';
  }
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
        0, (int value, element) => value += element == '#' ? 1 : 0);
    return value + rowCount;
  });
}

extension ListGetExtension<T> on List<List<T>> {
  T tryGet(int i, int j) =>
      i < 0 || j < 0 || i >= this.length || j >= this.first.length
          ? null
          : this[i][j];
}
