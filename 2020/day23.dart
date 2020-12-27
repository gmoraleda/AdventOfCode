import 'dart:collection';
import 'dart:math';

class CupEntry extends LinkedListEntry<CupEntry> {
  final value;
  CupEntry({
    this.value,
  });
  @override
  String toString() {
    return value.toString();
  }
}

main() {
  final input = "942387615";

  partOne(input);
  partTwo(input);
}

void partOne(String input) {
  final cups = input.split('').map((e) => int.parse(e)).toList();
  final inputMax = cups.reduce(max);

  var valueToCup = Map<int, CupEntry>();
  final linkedList = LinkedList<CupEntry>()
    ..addAll(cups.map((e) {
      final cup = CupEntry(value: e);
      valueToCup[e] = cup;
      return cup;
    }));

  var currentCup = linkedList.first;

  void move() {
    print('Current cup: $currentCup');
    print('Cups: $linkedList');

    var selectedCups = List<CupEntry>();
    var indexCup = currentCup;

    for (var i = 0; i < 3; i++) {
      final cup = indexCup.next ?? linkedList.first;
      indexCup = cup;
      selectedCups.add(cup);
    }
    final selectedCupsValues = selectedCups.map((e) => e.value);
    print('Selected: $selectedCups');

    for (var cup in selectedCups) {
      cup.unlink();
    }

    var destinationCup =
        valueToCup[currentCup.value - 1] ?? valueToCup[inputMax];

    while (selectedCupsValues.contains(destinationCup.value)) {
      print('Updating destination cup: $destinationCup');
      destinationCup =
          valueToCup[destinationCup.value - 1] ?? valueToCup[inputMax];
    }
    print('Destination: $destinationCup\n');

    destinationCup.insertAfter(selectedCups.first);
    selectedCups.first.insertAfter(selectedCups[1]);
    selectedCups[1].insertAfter(selectedCups.last);

    currentCup = currentCup.next ?? linkedList.first;
  }

  for (var i = 0; i < 100; i++) {
    move();
  }
  var finalCup = valueToCup[1].next;
  var result = '';
  for (var i = 0; i < 7; i++) {
    result += finalCup.value.toString();
    finalCup = finalCup.next ?? linkedList.first;
  }
  print(result);
}

void partTwo(String input) {
  final cups = input.split('').map((e) => int.parse(e)).toList();
  final newCups = List.generate(1000000 - cups.length, (index) => index + 10);
  final partTwoCups = cups + newCups;
  final inputMax = partTwoCups.reduce(max);

  var valueToCup = Map<int, CupEntry>();
  final linkedList = LinkedList<CupEntry>()
    ..addAll(partTwoCups.map((e) {
      final cup = CupEntry(value: e);
      valueToCup[e] = cup;
      return cup;
    }));

  var currentCup = linkedList.first;

  void move() {
    var selectedCups = List<CupEntry>();
    var indexCup = currentCup;

    for (var i = 0; i < 3; i++) {
      final cup = indexCup.next ?? linkedList.first;
      indexCup = cup;
      selectedCups.add(cup);
    }
    final selectedCupsValues = selectedCups.map((e) => e.value);
    for (var cup in selectedCups) {
      cup.unlink();
    }

    var destinationCup =
        valueToCup[currentCup.value - 1] ?? valueToCup[inputMax];

    while (selectedCupsValues.contains(destinationCup.value)) {
      destinationCup =
          valueToCup[destinationCup.value - 1] ?? valueToCup[inputMax];
    }

    destinationCup.insertAfter(selectedCups.first);
    selectedCups.first.insertAfter(selectedCups[1]);
    selectedCups[1].insertAfter(selectedCups.last);

    currentCup = currentCup.next ?? linkedList.first;
  }

  for (var i = 0; i < 10000000; i++) {
    move();
  }

  var firstFinalCup = valueToCup[1].next;
  var secondFinalCup = valueToCup[firstFinalCup.value].next;
  print(firstFinalCup.value * secondFinalCup.value);
}
