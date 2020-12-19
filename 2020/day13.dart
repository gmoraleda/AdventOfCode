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
      .where((element) => element != null)
      .toList();

  final departures = buses.map((e) => ((timestamp ~/ e * e) + e)).toList();
  final firstDeparture = departures.reduce(min);
  final busID = buses[departures.indexOf(firstDeparture)];

  print((firstDeparture - timestamp) * busID);

  // Part II (from: https://www.youtube.com/watch?v=4_5mluiXF5I)
  final departureList = input.last.split(',').toList();
  final busList = departureList.map((e) {
    if (int.tryParse(e) == null) {
      return 1;
    }
    return int.parse(e);
  }).toList();

  var t = 0;
  var stepSize = busList[0];
  for (var i = 1; i < busList.length; i++) {
    final bus = busList[i];
    while (((t + i) % bus != 0)) {
      t += stepSize;
    }
    stepSize *= bus;
  }
  print(t);
}
