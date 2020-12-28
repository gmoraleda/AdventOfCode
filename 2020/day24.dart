import 'dart:io';

main() {
  var path = 'input24.txt';
  final file = new File(path);
  final lines = file.readAsLinesSync().toList();

  var instructions = List<List<Direction>>();

  for (var line in lines) {
    var buffer = '';
    var lineDirections = List<Direction>();
    final chars = line.split('');

    for (var char in chars) {
      buffer += char;
      if (buffer.toDirection() != null) {
        lineDirections.add(buffer.toDirection());
        buffer = '';
      }
    }
    instructions.add(lineDirections);
  }

  final tileList = List<Tile>()..add(Tile());
  for (var instructionList in instructions) {
    var currentTile = tileList.first;
    for (var i = 0; i < instructionList.length; i++) {
      final flip = i == instructionList.length - 1;
      final direction = instructionList[i];

      switch (direction) {
        case Direction.e:
          if (currentTile.e != null) {
            currentTile.e.flip =
                flip ? !currentTile.e.flip : currentTile.e.flip;
          } else {
            var newTile = Tile();
            currentTile.e = newTile;

            newTile.w = currentTile;
            newTile.nw = currentTile.ne;
            newTile.sw = currentTile.se;
            tileList.add(newTile);

            currentTile.e.flip =
                flip ? !currentTile.e.flip : currentTile.e.flip;
          }
          currentTile = currentTile.e;
          break;

        case Direction.se:
          if (currentTile.se != null) {
            currentTile.se.flip =
                flip ? !currentTile.se.flip : currentTile.se.flip;
          } else {
            var newTile = Tile();
            currentTile.se = newTile;

            newTile.nw = currentTile;
            newTile.ne = currentTile.e;
            newTile.w = currentTile.sw;
            tileList.add(newTile);

            currentTile.se.flip =
                flip ? !currentTile.se.flip : currentTile.se.flip;
          }
          currentTile = currentTile.se;
          break;
        case Direction.sw:
          if (currentTile.sw != null) {
            currentTile.sw.flip =
                flip ? !currentTile.sw.flip : currentTile.sw.flip;
          } else {
            var newTile = Tile();
            currentTile.sw = newTile;

            newTile.ne = currentTile;
            newTile.e = currentTile.se;
            newTile.nw = currentTile.w;
            tileList.add(newTile);

            currentTile.sw.flip =
                flip ? !currentTile.sw.flip : currentTile.sw.flip;
          }
          currentTile = currentTile.sw;
          break;
        case Direction.w:
          if (currentTile.w != null) {
            currentTile.w.flip =
                flip ? !currentTile.w.flip : currentTile.w.flip;
          } else {
            var newTile = Tile();
            currentTile.w = newTile;

            newTile.e = currentTile;
            newTile.se = currentTile.sw;
            newTile.ne = currentTile.nw;
            tileList.add(newTile);

            currentTile.w.flip =
                flip ? !currentTile.w.flip : currentTile.w.flip;
          }
          currentTile = currentTile.w;
          break;
        case Direction.nw:
          if (currentTile.nw != null) {
            currentTile.nw.flip =
                flip ? !currentTile.nw.flip : currentTile.nw.flip;
          } else {
            var newTile = Tile();
            currentTile.nw = newTile;

            newTile.se = currentTile;
            newTile.sw = currentTile.w;
            newTile.e = currentTile.nw;
            tileList.add(newTile);

            currentTile.nw.flip =
                flip ? !currentTile.nw.flip : currentTile.nw.flip;
          }
          currentTile = currentTile.nw;
          break;
        case Direction.ne:
          if (currentTile.ne != null) {
            currentTile.ne.flip =
                flip ? !currentTile.ne.flip : currentTile.ne.flip;
          } else {
            var newTile = Tile();
            currentTile.ne = newTile;

            newTile.sw = currentTile;
            newTile.se = currentTile.e;
            newTile.w = currentTile.nw;
            tileList.add(newTile);

            currentTile.ne.flip =
                flip ? !currentTile.ne.flip : currentTile.ne.flip;
          }
          currentTile = currentTile.ne;
          break;
      }
    }
    print(tileList);
  }

  var count = 0;
  for (var tile in tileList) {
    count += tile.flip ? 1 : 0;
  }
  print(count);
}

enum Direction { e, se, sw, w, nw, ne }

extension EnumParser on String {
  Direction toDirection() {
    return Direction.values.firstWhere(
        (e) => e.toString().toLowerCase() == 'direction.$this'.toLowerCase(),
        orElse: () => null);
  }
}

class Tile {
  bool flip = false;

  Tile e;
  Tile se;
  Tile sw;
  Tile w;
  Tile nw;
  Tile ne;

  @override
  String toString() {
    return flip.toString();
  }
}
