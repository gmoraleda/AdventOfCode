import 'dart:io';

main() {
  var path = 'input19.txt';

  final file = new File(path);
  final input = file.readAsStringSync().split('\n\n');
  final rules = input.first.split('\n');
  final messages = input.last.split('\n');

  final regex = RegExp(r'(\d+?): (.*)');

  Map<String, List<String>> ruleMap = Map.fromIterable(rules,
      key: (v) => regex.firstMatch(v).group(1),
      value: (v) => regex.firstMatch(v).group(2).split(' | ').toList());

  print(ruleMap);

  final aKey =
      ruleMap.keys.firstWhere((element) => ruleMap[element].contains("\"a\""));
  ruleMap[aKey] = ["a"];
  final bKey =
      ruleMap.keys.firstWhere((element) => ruleMap[element].contains("\"b\""));
  ruleMap[bKey] = ["b"];

  // Initial Substitution
  final digitRegex = new RegExp(r'(\b\d+?\b)');
  ruleMap.updateAll((key, value) {
    return value
        .map((e) => e
            .replaceAll(RegExp("\\b(${aKey})\\b"), "a")
            .replaceAll(RegExp("\\b(${bKey})\\b"), "b"))
        .toList();
  });

  while (ruleMap["0"].any((element) => element.contains(digitRegex))) {
    for (var entry in ruleMap.entries.where((element) =>
        element.value.any((element) => digitRegex.hasMatch(element)))) {
      var newValue = List<String>();
      entry.value.forEach((element) {
        if (digitRegex.hasMatch(element)) {
          final key = digitRegex.firstMatch(element).group(1);
          ruleMap[key].forEach((e) {
            newValue.add(element.replaceAll(key, e));
          });
        }
      });

      ruleMap[entry.key] = newValue;
    }
  }

  final spacedMessages =
      messages.map((e) => e.split('').join(' ').trim()).toList();
  final dictionary = Map.fromIterable(ruleMap["0"]);
  print(spacedMessages.first);

  var validCounter = 0;
  for (var message in spacedMessages) {
    if (dictionary[message] != null) validCounter++;
  }
  print(validCounter);
}
