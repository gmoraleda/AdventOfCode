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
  final partOneRegex = RegExp('^${computedRules[rules["0"]]}\$');

  for (var message in messages) {
    if (partOneRegex.hasMatch(message)) count++;
  }
  print(count);

  rules["0"] = "8 11";
  rules["8"] = "42 | 42 8";
  rules["11"] = "42 31 | 42 11 31";

  computedRules.clear();
  computeRule(rules["42"], rules);
  computeRule(rules["31"], rules);

  final partTwoRegex = RegExp(
      '^(?<group42>(${computedRules[rules["42"]]})+)(?<group31>(${computedRules[rules["31"]]})+)\$');
  count = 0;

  for (var message in messages) {
    if (partTwoRegex.allMatches(message).any((element) {
      final group42 = element.namedGroup("group42").length;
      final group31 = element.namedGroup("group31").length;

      return group42 > group31;
    })) {
      count++;
    }
  }
  print(count);
}
