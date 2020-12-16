import 'dart:io';

main() {
  var path = 'input11.txt';

  final file = new File(path);
  final input = file.readAsLinesSync().map((e) => e.split('')).toList();

  var output = partOne(input);
  // var output = partTwo(input);

  while (true) {
    var temp = partOne(output);
    // var temp = partTwo(output);
    output = temp;
    print('${countSeats(output)}');
  }
}

List<List<String>> partOne(List<List<String>> input) {
  final List<List<String>> copy =
      input.map((element) => List<String>.from(element)).toList();

  for (var i = 0; i < input.length; i++) {
    for (var j = 0; j < input.first.length; j++) {
      switch (input[i][j]) {
        case '.':
          copy[i][j] = '.';
          continue;
        case 'L':
          if (isAvailablePartOne(input, i, j)) {
            copy[i][j] = '#';
          }
          continue;
        case '#':
          if (standPartOne(input, i, j)) {
            copy[i][j] = 'L';
          }
          continue;
      }
    }
  }
  return copy;
}

List<List<String>> partTwo(List<List<String>> input) {
  final List<List<String>> copy =
      input.map((element) => List<String>.from(element)).toList();

  for (var i = 0; i < input.length; i++) {
    for (var j = 0; j < input.first.length; j++) {
      switch (input[i][j]) {
        case '.':
          copy[i][j] = '.';
          continue;
        case 'L':
          if (isAvailable(input, i, j)) {
            copy[i][j] = "#";
          }
          continue;
        case '#':
          if (stand(input, i, j)) {
            copy[i][j] = "L";
          }
          continue;
      }
    }
  }
  return copy;
}

String check(
    List<List<String>> input, int currentI, int dI, int currentJ, int dJ) {
  if (input.tryGet(currentI + dI, currentJ + dJ) == null) {
    return null;
  }
  return input[currentI + dI][currentJ + dJ];
}

bool isAvailablePartOne(List<List<String>> input, int i, int j) {
  var up = check(input, i, -1, j, 0);
  var down = check(input, i, 1, j, 0);
  var right = check(input, i, 0, j, 1);
  var left = check(input, i, 0, j, -1);
  var upRight = check(input, i, -1, j, 1);
  var downRight = check(input, i, 1, j, 1);
  var upLeft = check(input, i, -1, j, -1);
  var downLeft = check(input, i, 1, j, -1);

  return [up, down, right, left, upRight, downRight, upLeft, downLeft]
      .where((element) => element == "#")
      .isEmpty;
}

bool standPartOne(List<List<String>> input, int i, int j) {
  var up = check(input, i, -1, j, 0);
  var down = check(input, i, 1, j, 0);
  var right = check(input, i, 0, j, 1);
  var left = check(input, i, 0, j, -1);
  var upRight = check(input, i, -1, j, 1);
  var downRight = check(input, i, 1, j, 1);
  var upLeft = check(input, i, -1, j, -1);
  var downLeft = check(input, i, 1, j, -1);

  return [up, down, right, left, upRight, downRight, upLeft, downLeft]
          .where((element) => element == "#")
          .length >=
      4;
}

String move(
    List<List<String>> input, int currentI, int dI, int currentJ, int dJ) {
  if (input.tryGet(currentI + dI, currentJ + dJ) == null) {
    return null;
  }
  if (input.tryGet(currentI + dI, currentJ + dJ) != '.') {
    return input[currentI + dI][currentJ + dJ];
  }
  return move(input, currentI + dI, dI, currentJ + dJ, dJ);
}

bool isAvailable(List<List<String>> input, int i, int j) {
  var up = move(input, i, -1, j, 0);
  var down = move(input, i, 1, j, 0);
  var right = move(input, i, 0, j, 1);
  var left = move(input, i, 0, j, -1);
  var upRight = move(input, i, -1, j, 1);
  var downRight = move(input, i, 1, j, 1);
  var upLeft = move(input, i, -1, j, -1);
  var downLeft = move(input, i, 1, j, -1);

  return [up, down, right, left, upRight, downRight, upLeft, downLeft]
      .where((element) => element == "#")
      .isEmpty;
}

bool stand(List<List<String>> input, int i, int j) {
  var up = move(input, i, -1, j, 0);
  var down = move(input, i, 1, j, 0);
  var right = move(input, i, 0, j, 1);
  var left = move(input, i, 0, j, -1);
  var upRight = move(input, i, -1, j, 1);
  var downRight = move(input, i, 1, j, 1);
  var upLeft = move(input, i, -1, j, -1);
  var downLeft = move(input, i, 1, j, -1);

  return [up, down, right, left, upRight, downRight, upLeft, downLeft]
          .where((element) => element == "#")
          .length >=
      5;
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
