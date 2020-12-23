import 'dart:io';

main() {
  var path = 'input18.txt';

  final file = new File(path);
  final input =
      file.readAsLinesSync().map((e) => e.replaceAll(' ', '').split(''));

  solve(input, computeStackLeftToRight);
  solve(input, computeStackWithPrecedence);
}

void solve(
    Iterable<List<String>> input, String computeFunction(List<dynamic> stack)) {
  var result = 0;
  for (var line in input) {
    var stack = List<String>();
    for (var element in line) {
      if (int.tryParse(element) != null ||
          element == '*' ||
          element == '+' ||
          element == '(') {
        stack.add(element);
      } else if (element == ')') {
        var tempStack = [];
        var item = stack.removeLast();
        while (item != '(') {
          tempStack.insert(0, item);
          item = stack.removeLast();
        }
        stack.add(computeFunction(tempStack));
      }
    }
    result += int.parse(computeFunction(stack));
  }
  print('$result');
}

String computeStackWithPrecedence(List<dynamic> stack) {
  var tempStack = List<String>();
  for (var i = 0; i < stack.length; i++) {
    if (stack[i] == '+') {
      final a = tempStack.removeLast();
      tempStack
          .add(compute(int.parse(a), int.parse(stack[i + 1]), '+').toString());
      i++;
    } else {
      tempStack.add(stack[i]);
    }
  }
  return tempStack
      .where((element) => element != '*')
      .map((e) => int.parse(e))
      .reduce((value, element) => value *= element)
      .toString();
}

String computeStackLeftToRight(List<dynamic> stack) {
  while (stack.length > 1) {
    int a = int.parse(stack.removeAt(0));
    String operator = stack.removeAt(0);
    int b = int.parse(stack.removeAt(0));

    stack.insert(0, compute(a, b, operator).toString());
  }
  return stack.last;
}

num compute(num a, num b, String operator) {
  switch (operator) {
    case '+':
      return a + b;
    case '*':
      return a * b;
    default:
      throw AssertionError('Unknown operator $operator');
  }
}
