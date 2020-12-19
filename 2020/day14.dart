import 'dart:io';

main() {
  var path = 'input14.txt';

  final file = new File(path);
  final input = file.readAsLinesSync().toList();

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

      var result = List<String>();
      for (var i = 0; i < currentMask.length; i++) {
        result.add(currentMask[i] == 'X' ? correctedLength[i] : currentMask[i]);
      }
      memory[address] = result;
    }
  }

  var total = 0;
  memory.forEach((key, value) {
    var num = int.parse(value.join(), radix: 2);
    total += num;
  });
  print(total);
}
