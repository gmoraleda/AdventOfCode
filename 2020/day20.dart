import 'dart:io';

main() {
  var path = 'input20.txt';

  final file = new File(path);
  final tiles = file.readAsStringSync().split('\n\n').map((e) {
    final split = e.split('\n');
    return Tile(
        id: int.parse(split.first.replaceFirst(':', '').split(' ').last),
        grid: split.sublist(1));
  }).toList();

  var matches = Map<Tile, Set<Tile>>();

  for (var i = 0; i < tiles.length; i++) {
    for (var j = 0; j < tiles.length; j++) {
      if (tiles[i].id == tiles[j].id) continue;

      for (var border in tiles[i].borders) {
        if (tiles[j].borders.contains(border)) {
          if (matches[tiles[i]] != null)
            matches[tiles[i]].add(tiles[j]);
          else
            matches[tiles[i]] = Set.of([tiles[j]]);
          break;
        }
      }
    }
  }

  final corners = matches.entries
      .where((element) => element.value.length == 2)
      .map((e) => (e.key.id));

  print(corners);
  print(corners.reduce((value, element) => value *= element));
}

class Tile {
  final int id;
  final List<String> grid;
  Tile({
    this.id,
    this.grid,
  });

  List<String> get borders {
    var firstColumn = '';
    var lastColumn = '';
    for (var line in grid) {
      firstColumn += line[0];
      lastColumn += line[line.length - 1];
    }
    return [firstColumn, lastColumn, grid.first, grid.last] +
        [
          firstColumn.split('').reversed.join(''),
          lastColumn.split('').reversed.join(''),
          grid.first.split('').reversed.join(''),
          grid.last.split('').reversed.join('')
        ];
  }

  @override
  String toString() {
    return "\n$id";
  }
}
