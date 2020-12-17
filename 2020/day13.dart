import 'dart:io';
import 'dart:math';

main() {
  var path = 'input13.txt';

  final file = new File(path);
  final input = file.readAsLinesSync().toList();

  final timestamp = int.parse(input.first);
  final buses = input.last
      .split(',')
      .map((e) => int.tryParse(e))
      .toList()
      .where((element) => element != null)
      .toList();

  final departures = buses.map((e) => ((timestamp ~/ e * e) + e)).toList();
  final firstDeparture = departures.reduce(min);
  final busID = buses[departures.indexOf(firstDeparture)];

  print((firstDeparture - timestamp) * busID);
}
