import 'dart:io';

main() {
  var path = 'input9.txt';

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
      print('Part I: $number');
      break;
    }
  }

  // Part 2
  var target = 1721308972;
  var indexOfTarget = input.indexOf(target);

  for (var i = indexOfTarget - 1; i >= 0; i--) {
    for (var j = i - 1; j >= 0; j--) {
      var window = input.sublist(j, i);
      var sum = window.reduce((value, element) => value + element);

      if (sum == target) {
        window.sort();
        print('Part II: ${window.first + window.last}');
        exit(1);
      }
    }
  }
}
