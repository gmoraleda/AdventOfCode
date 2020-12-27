main() {
  final input = "389125467";

  final cups = input.split('').map((e) => int.parse(e)).toList();
  final newCups = List.generate(1000000 - cups.length, (index) => index + 10);
  final partTwoCups = cups + newCups;

  var currentCup = cups.first;
  void move(List<int> cups) {
    // print(cups.map((e) {
    //   if (currentCup == e) {
    //     return "($e)";
    //   } else {
    //     return " $e ";
    //   }
    // }));

    final currentCupIndex = cups.indexOf(currentCup);
    final selectedCups = cups.getCups((currentCupIndex + 1) % cups.length,
        (currentCupIndex + 4) % cups.length);

    // print('pick up: $selectedCups');

    var destination = (currentCup - 1);
    while (selectedCups.contains(destination) || destination <= 0) {
      destination = (destination - 1) % (cups.length + 1);
    }

    // print('destination: $destination');

    cups.removeWhere((element) => selectedCups.contains(element));
    // print(cups);

    final destinationCupIndex = cups.indexOf(destination);
    cups.insertAll((destinationCupIndex + 1), selectedCups);
    // print(cups);

    final newCurrentCupIndex = cups.indexOf(currentCup);
    currentCup = cups[(newCurrentCupIndex + 1) % cups.length];
  }

  for (var i = 0; i < 100; i++) {
    move(cups);
  }
  print(cups.rotate(cups.indexOf(1) + 1).join().replaceAll('1', ''));

  // for (var i = 0; i < 10000000; i++) {
  //   move(partTwoCups);
  // }
  // print(cups[cups.indexOf(1) + 1] * cups[cups.indexOf(1) + 2]);
}

extension Cups on List {
  List<int> getCups(int start, int end) {
    if (start > end) {
      final partA = this.sublist(start);
      final partB = this.sublist(0, end);
      return partA + partB;
    } else {
      return this.sublist(start, end);
    }
  }

  List<Object> rotate(int v) {
    if (this == null || this.isEmpty) return this;
    var i = v % this.length;
    return this.sublist(i)..addAll(this.sublist(0, i));
  }
}
