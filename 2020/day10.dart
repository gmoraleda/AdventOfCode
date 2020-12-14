import 'dart:io';

main() {
  var path = './2020/input10.txt';

  final file = new File(path);
  final input = file.readAsLinesSync().map((e) => int.parse(e)).toList();

  input.add(0);
  input.sort();
  input.add(input.last + 3);

  // Part 1
  var ones = 0;
  var threes = 0;

  for (var i = 1; i < input.length; i++) {
    if (input[i] - input[i - 1] == 1) {
      ones++;
    } else {
      threes++;
    }
  }
  print(ones * threes);

  // Part 2
  var cache = Map<int, int>();
  int checkChain({int i = 0}) {
    if (cache[i] != null) {
      return cache[i];
    }

    if (i == input.length - 1) {
      return 1;
    }

    var count = 0;
    if (i + 1 < input.length && input[i + 1] - input[i] <= 3) {
      count += checkChain(i: i + 1);
    }

    if (i + 2 < input.length && input[i + 2] - input[i] <= 3) {
      count += checkChain(i: i + 2);
    }

    if (i + 3 < input.length && input[i + 3] - input[i] <= 3) {
      count += checkChain(i: i + 3);
    }

    cache[i] = count;
    return count;
  }

  print(checkChain());
}
