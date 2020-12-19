import 'dart:io';

main() {
  var path = 'input14.txt';

  final file = new File(path);
  final input = file.readAsLinesSync().toList();

  partOne(input);
  partTwo(input);
}

void partOne(List<String> input) {
  var currentMask = List<String>();
  var memory = Map<String, List<String>>();

  for (var line in input) {
    final components = line.split(' = ');

    if (components.first == "mask") {
      currentMask = components.last.split('').toList();
    } else {
      final regex = RegExp(r"(\d+)");
      final address = regex.firstMatch(components.first).group(0);

      var binary = int.parse(components.last).toRadixString(2).split('');
      var correctedLength =
          List.generate(36 - binary.length, (index) => '0') + binary;

      var entry = List<String>();
      for (var i = 0; i < currentMask.length; i++) {
        entry.add(currentMask[i] == 'X' ? correctedLength[i] : currentMask[i]);
      }
      memory[address] = entry;
    }
  }

  var total = 0;
  memory.forEach((key, value) {
    var num = int.parse(value.join(), radix: 2);
    total += num;
  });
  print(total);
}

void partTwo(List<String> input) {
  var currentMask = List<String>();
  var memory = Map<int, List<String>>();
  for (var line in input) {
    final components = line.split(' = ');

    if (components.first == "mask") {
      currentMask = components.last.split('').toList();
    } else {
      final address = RegExp(r"(\d+)").firstMatch(components.first).group(0);
      final addressBinary =
          fillLength(int.parse(address).toRadixString(2).split(''));

      final valueToWrite =
          int.parse(components.last).toRadixString(2).split('');

      var maskedAddress = List<String>();
      for (var i = 0; i < currentMask.length; i++) {
        maskedAddress
            .add(currentMask[i] == '0' ? addressBinary[i] : currentMask[i]);
      }

      final addressToWrite = calculateVariations(maskedAddress);

      for (var address in addressToWrite) {
        var num = int.parse(address.join(), radix: 2);
        memory[num] = valueToWrite;
      }
    }
  }
  var total = 0;
  memory.forEach((key, value) {
    var num = int.parse(value.join(), radix: 2);
    total += num;
  });
  print(total);
}

List<String> fillLength(List<String> binary) {
  return List.generate(36 - binary.length, (index) => '0') + binary;
}

// Part II

List<List<String>> calculateVariations(List<String> list) {
  var result = List<List<String>>();
  void fillFloatingBits(List<String> list, {int index = 0}) {
    var currentResult = List<String>.from(list);
    for (var i = index; i < list.length; i++) {
      if (list[i] == 'X') {
        var zero = List<String>.from(list);
        zero[i] = '0';
        fillFloatingBits(zero, index: i + 1);

        var one = List<String>.from(list);
        one[i] = '1';
        fillFloatingBits(one, index: i + 1);
        return;
      }
    }
    result.add(currentResult);
  }

  fillFloatingBits(list);
  return result;
}
