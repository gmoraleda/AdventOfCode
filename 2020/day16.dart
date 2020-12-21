import 'dart:io';

main() {
  var path = 'input16.txt';

  final file = new File(path);
  final input = file.readAsStringSync().split('\n\n');
  final rangesRaw = input[0];
  final myTickets = input[1];
  var nearbyTickets = List<int>();
  input[2].split('\n').sublist(1).forEach((row) {
    nearbyTickets.addAll(row.split(',').map((e) => int.parse(e)));
  });

  var ranges = [];
  rangesRaw.split('\n').forEach((element) {
    element.split(':').last.trim().split(" or ").forEach((element) {
      final numbers = element.split('-');
      ranges.add(
          Range(min: int.parse(numbers.first), max: int.parse(numbers.last)));
    });
  });

  var invalidTickets = [];

  for (var i = 0; i < nearbyTickets.length; i++) {
    final ticket = nearbyTickets[i];
    var valid = false;
    for (var j = 0; j < ranges.length; j++) {
      if (ticket.inRange(ranges[j])) {
        valid = true;
        break;
      }
    }
    if (!valid) {
      invalidTickets.add(ticket);
    }
  }

  // Part I
  print(invalidTickets.reduce((value, element) => value + element));
}

extension NumExtension on num {
  bool inRange(Range range) {
    return this >= range.min && this <= range.max;
  }
}

class Range {
  int min;
  int max;
  Range({
    this.min,
    this.max,
  });
  @override
  String toString() {
    return "$min - $max";
  }
}
