import 'dart:io';

main() {
  var path = './2020/input9.txt';

  final file = new File(path);
  final input = file.readAsLinesSync().map((e) => int.parse(e)).toList();

  // Part 1
  var windowSize = 25;

  for (var i = windowSize; i < input.length; i++) {
    var number = input[i];
    var window = input.sublist(i - windowSize, i);
    var valid = false;
    for (var element in window) {
      if (window.contains(number - element)) {
        valid = true;
        break;
      }
    }
    if (!valid) {
      print('Invalid: $number');
      exit(1);
    }
  }

  // Part 2
  windowSize = 3;
  var target = 1721308972;
  for (var i = windowSize; i < input.length; i++) {
    var number = input[i];
    var window = input.sublist(i - windowSize, i);

    var valid = false;
    for (var element in window) {
      if (window.contains(number - element)) {
        valid = true;
        break;
      }
    }
    if (!valid) {
      print('Invalid: $number');
      exit(1);
    }
  }
}
