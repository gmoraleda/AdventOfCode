import 'dart:io';
import 'dart:math';

import 'package:vector_math/vector_math.dart';

class Position {
  int x;
  int y;
  Position({
    this.x,
    this.y,
  });

  int get quadrant {
    if (x > 0 && y > 0) {
      return 1;
    }
    if (x > 0 && y < 0) {
      return 2;
    }
    if (x < 0 && y < 0) {
      return 3;
    }
    return 4;
  }

  @override
  String toString() {
    return "[$x,$y]";
  }
}

main() {
  var path = 'input12.txt';

  final file = new File(path);
  final input = file.readAsLinesSync().toList();

  var currentDirection = 'E';
  var positionPartOne = Position(x: 0, y: 0);

  var positionPartTwo = Position(x: 0, y: 0);
  var waypointPosition = Position(x: 10, y: 1);

  var instructions = input.map((e) {
    var action = e[0];
    var value = int.parse(e.substring(1));
    return Pair(action, value);
  });

  void updateDirection(String action, int value) {
    var positions = ['E', 'S', 'W', 'N'];
    var moves = value ~/ 90;

    if (action == 'L') {
      moves = -moves;
    }

    var currentIndex = positions.indexOf(currentDirection);
    currentDirection = positions[(currentIndex + moves) % positions.length];
  }

  void rotate(String action, int value) {
    if (action == "R") {
      value = -value;
    }
    var c = cos(radians(value.toDouble()));
    var s = sin(radians(value.toDouble()));

    var newX = c * waypointPosition.x - s * waypointPosition.y;
    var newY = s * waypointPosition.x + c * waypointPosition.y;

    waypointPosition.x = newX.round();
    waypointPosition.y = newY.round();
  }

  void move(String action, int value) {
    switch (action) {
      case 'N':
        positionPartOne.y += value;
        return;
      case 'S':
        positionPartOne.y -= value;
        return;
      case 'E':
        positionPartOne.x += value;
        return;
      case 'W':
        positionPartOne.x -= value;
        return;
      case 'L':
      case 'R':
        updateDirection(action, value);
        return;
      case 'F':
        move(currentDirection, value);
        return;
    }
  }

  void move2(String action, int value) {
    switch (action) {
      case 'N':
        waypointPosition.y += value;
        return;
      case 'S':
        waypointPosition.y -= value;
        return;
      case 'E':
        waypointPosition.x += value;
        return;
      case 'W':
        waypointPosition.x -= value;
        return;
      case 'L':
      case 'R':
        rotate(action, value);
        return;
      case 'F':
        positionPartTwo.x += waypointPosition.x * value;
        positionPartTwo.y += waypointPosition.y * value;
        return;
    }
  }

  for (var instruction in instructions) {
    move(instruction.action, instruction.value);
  }
  print('Part I: ${positionPartOne.x.abs() + positionPartOne.y.abs()}');

  for (var instruction in instructions) {
    move2(instruction.action, instruction.value);
  }
  print('Part II: ${positionPartTwo.x.abs() + positionPartTwo.y.abs()}');
}

class Pair<T1, T2> {
  final T1 action;
  final T2 value;

  Pair(this.action, this.value);
  @override
  String toString() {
    return "$action - $value";
  }
}
