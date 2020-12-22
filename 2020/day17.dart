import 'dart:io';

import 'package:equatable/equatable.dart';

main() {
  var path = 'input17.txt';

  final file = new File(path);
  final input = file.readAsLinesSync().map((e) => e.split('')).toList();

  var activeCubes = Set<Cube>();
  for (var y = 0; y < input.length; y++) {
    for (var x = 0; x < input.first.length; x++) {
      if (input[y][x] == "#") {
        activeCubes.add(Cube(x: x, y: y, z: 0, w: 0));
      }
    }
  }

  print("0 -- ${activeCubes.length}");

  for (var i = 1; i < 7; i++) {
    var copy = Set<Cube>.from(activeCubes);

    activeCubes.forEach((cube) {
      final neighbours = getNeighbours(cube);
      final activeNeighbourCount = neighbours.intersection(activeCubes).length;

      if (activeNeighbourCount != 2 && activeNeighbourCount != 3) {
        copy.remove(cube);
      }

      neighbours.forEach((neighbour) {
        if (getNeighbours(neighbour).intersection(activeCubes).length == 3) {
          copy.add(neighbour);
        }
      });
    });

    activeCubes = copy;
    print("$i -- ${activeCubes.length}");
  }
}

Set<Cube> getNeighbours(Cube cube) {
  var neighbours = Set<Cube>();

  for (var x = -1; x <= 1; x++) {
    for (var y = -1; y <= 1; y++) {
      for (var z = -1; z <= 1; z++) {
        for (var w = -1; w <= 1; w++) {
          neighbours.add(
              Cube(x: cube.x + x, y: cube.y + y, z: cube.z + z, w: cube.w + w));
        }
      }
    }
  }
  neighbours.remove(cube);
  return neighbours;
}

class Cube extends Equatable {
  final int x;
  final int y;
  final int z;
  final int w;

  Cube({this.x, this.y, this.z, this.w});

  @override
  String toString() {
    return "x:$x y:$y z:$z w:$w";
  }

  @override
  List<Object> get props => [x, y, z, w];
}
