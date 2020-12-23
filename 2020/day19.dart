import 'dart:io';

main() {
  var path = 'input19.txt';

  final file = new File(path);
  final input = file.readAsStringSync().split('\n\n');
  final messages = input.last.split('\n');

  final regex = RegExp(r'(\d+?): (.*)');

  Map<String, String> rules = Map.fromIterable(input.first.split('\n'),
      key: (v) => regex.firstMatch(v).group(1),
      value: (v) => regex.firstMatch(v).group(2));

  var computedRules = Map<String, String>();

  String computeRule(String rule, Map<String, String> rules) {
    if (computedRules[rule] != null) {
      return computedRules[rule];
    }
    var result = '';
    if (rule.contains("\"")) {
      result = rule.replaceAll("\"", '');
    } else if (rule.contains("|")) {
      result =
          '(${computeRule(rule.split(" | ").first, rules)}|${computeRule(rule.split(" | ").last, rules)})';
    } else {
      final keys = rule.split(' ');
      result = keys.map((e) => computeRule(rules[e], rules)).join();
    }
    computedRules[rule] = result;
    return result;
  }

  computeRule(rules["0"], rules);

  var count = 0;
  final masterRegex = RegExp('^${computedRules[rules["0"]]}\$');

  for (var message in messages) {
    if (masterRegex.hasMatch(message)) count++;
  }
  print(count);
}
