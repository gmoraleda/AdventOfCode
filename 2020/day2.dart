import 'dart:io';

class PasswordPolicy {
  PasswordPolicy({
    this.min,
    this.max,
    this.match,
    this.password,
  });

  int min;
  int max;
  String match;
  String password;

  bool get isValid {
    final a = password[min - 1];
    final b = password[max - 1];

    return (a == match || b == match) && a != b;
  }

  @override
  String toString() {
    return '$min - $max - $match - $password \n';
  }
}

main() {
  var path = 'input2.txt';
  final file = new File(path);
  final List<String> list = file.readAsLinesSync();
  final List<PasswordPolicy> policies = list.map((e) {
    var components = e.split(' ');
    var minMax = components[0].split('-');
    return PasswordPolicy(
        min: int.parse(minMax[0]),
        max: int.parse(minMax[1]),
        match: components[1][0],
        password: components[2]);
  }).toList();

  print(policies.where((element) => element.isValid).length);
}
