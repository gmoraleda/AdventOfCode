import 'dart:io';

main() {
  var path = 'input16.txt';

  final file = new File(path);
  final input = file.readAsStringSync().split('\n\n');
  final rangesRaw = input[0];
  final myTicket =
      input[1].split('\n').last.split(',').map((e) => int.parse(e)).toList();
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

  // Part II
  final departureRanges = ranges;
  var rangePairs = [];
  for (var i = 0; i < departureRanges.length; i += 2) {
    rangePairs.add(RangePair(a: departureRanges[i], b: departureRanges[i + 1]));
  }

  final filteredNearbyTickets = input[2].split('\n').sublist(1).map((row) {
    return row.split(',').map((e) => int.parse(e)).toList();
  }).where((element) {
    final firstSet = element.toSet();
    final secondSet = invalidTickets.toSet();
    return firstSet.intersection(secondSet).isEmpty;
  }).toList();

  var departureColumns = List<List<int>>();
  for (var i = 0; i < rangePairs.length; i++) {
    var currentPair = rangePairs[i];
    var currentMatches = List<int>();
    for (var j = 0; j < filteredNearbyTickets.first.length; j++) {
      var column = filteredNearbyTickets.map((e) => e[j]).toList();
      if (column.every((element) => element.inRangePair(currentPair))) {
        currentMatches.add(j);
      }
    }
    departureColumns.add(currentMatches);
  }

  var identifiedFields = List<dynamic>.generate(20, (index) => null);
  while (identifiedFields.any((element) => element == null)) {
    for (var column in departureColumns) {
      if (column.length == 1) {
        final index = departureColumns.indexOf(column);
        final number = column.first;
        identifiedFields[index] = number;

        for (var column in departureColumns) {
          column.remove(number);
        }
      }
    }
  }
  var result = 1;
  for (var i = 0; i < 6; i++) {
    result *= myTicket[identifiedFields[i]];
  }
  print(result);
}

extension NumExtension on num {
  bool inRange(Range range) {
    return this >= range.min && this <= range.max;
  }

  bool inRangePair(RangePair pair) {
    return (this.inRange(pair.a) || this.inRange(pair.b));
  }
}

class RangePair {
  Range a;
  Range b;
  RangePair({
    this.a,
    this.b,
  });
  @override
  String toString() {
    return "$a or $b";
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
