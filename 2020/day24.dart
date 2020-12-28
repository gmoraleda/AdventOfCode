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

  final flippedTiles = Set<String>();

  for (var instructionList in instructions) {
    var referenceTile = Tile();
    referenceTile.x = 0;
    referenceTile.y = 0;

    for (var i = 0; i < instructionList.length; i++) {
      final flip = i == instructionList.length - 1;
      final direction = instructionList[i];

      switch (direction) {
        case Direction.e:
          referenceTile.x += 2;
          break;
        case Direction.se:
          referenceTile.x += 1;
          referenceTile.y -= 1;
          break;
        case Direction.sw:
          referenceTile.x -= 1;
          referenceTile.y -= 1;
          break;
        case Direction.w:
          referenceTile.x -= 2;
          break;
        case Direction.nw:
          referenceTile.x -= 1;
          referenceTile.y += 1;
          break;
        case Direction.ne:
          referenceTile.x += 1;
          referenceTile.y += 1;
          break;
      }

      if (flip) {
        if (flippedTiles.contains(referenceTile.toString()))
          flippedTiles.remove(referenceTile.toString());
        else
          flippedTiles.add(referenceTile.toString());
      }
    }
  }
  print('Part I: ${flippedTiles.length}');

  for (var i = 1; i <= 100; i++) {
    var tilesToRemove = Set<String>();
    var tilesToAdd = Set<String>();

    for (var tileString in flippedTiles) {
      var blackCount = 0;
      var tile = Tile.fromString(tileString);

      tile.neighbours.forEach((neighbour) {
        // Black
        if (flippedTiles.contains(neighbour.toString())) {
          blackCount++;
        } else {
          // White
          var toAddCount = 0;
          neighbour.neighbours.forEach((neighboursNeighbour) {
            if (flippedTiles.contains(neighboursNeighbour.toString()))
              toAddCount++;
          });
          if (toAddCount == 2) {
            tilesToAdd.add(neighbour.toString());
          }
        }
      });

      if (blackCount == 0 || blackCount > 2) {
        tilesToRemove.add(tile.toString());
      }
    }

    flippedTiles.removeAll(tilesToRemove);
    flippedTiles.addAll(tilesToAdd);

    print('Day $i: ${flippedTiles.length}');
  }
}

/* 
--------(-1,1)---|---(1,1)---------
           |     |     |
--(-2,0)-------(0,0)-------(2,0)---
           |     |     |
-------(-1,-1)---|---(1,-1)--------
*/

enum Direction { e, se, sw, w, nw, ne }

extension EnumParser on String {
  Direction toDirection() {
    return Direction.values.firstWhere(
        (e) => e.toString().toLowerCase() == 'direction.$this'.toLowerCase(),
        orElse: () => null);
  }
}

class Tile {
  int x;
  int y;
  Tile({
    this.x,
    this.y,
  });
  Tile.fromString(String string) {
    this.x = int.parse(string.split(':').first);
    this.y = int.parse(string.split(':').last);
  }

  @override
  String toString() {
    return "$x:$y";
  }

  List<Tile> get neighbours {
    var list = List<Tile>();

    list.add(Tile(x: this.x + 2, y: this.y));
    list.add(Tile(x: this.x + 1, y: this.y - 1));
    list.add(Tile(x: this.x - 1, y: this.y - 1));
    list.add(Tile(x: this.x - 2, y: this.y));
    list.add(Tile(x: this.x - 1, y: this.y + 1));
    list.add(Tile(x: this.x + 1, y: this.y + 1));

    return list;
  }
}
