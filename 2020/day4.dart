import 'dart:io';

main() {
  var path = 'input4.txt';

  final file = new File(path);
  final string = file.readAsStringSync();
  final List<String> list =
      string.trim().split('\n\n').map((e) => e.replaceAll('\n', ' ')).toList();

  final passports = list.map((e) {
    var components = e.split(' ');

    return new Map<String, String>.fromIterable(components, key: (item) {
      return item.toString().split(':')[0];
    }, value: (item) {
      return item.toString().split(':')[1];
    });
  }).toList();

  final partOne = passports.where((element) {
    return element.length == 8 ||
        (element.length == 7 && !element.containsKey('cid'));
  });

  final partTwo = partOne.where((element) {
    return isElementValid(element);
  });

  print(partOne.length);
  print(partTwo.length);
}

bool isElementValid(Map element) {
  return (isValidByr(element['byr']) &&
      isValidIyr(element['iyr']) &&
      isValidEyr(element['eyr']) &&
      isValidHeight(element['hgt']) &&
      isValidHex(element['hcl']) &&
      isValidEyeColor(element['ecl']) &&
      isValidPassport(element['pid']));
}

bool isValidByr(String str) {
  return str.length == 4 && int.parse(str) >= 1920 && int.parse(str) <= 2002;
}

bool isValidIyr(String str) {
  return str.length == 4 && int.parse(str) >= 2010 && int.parse(str) <= 2020;
}

bool isValidEyr(String str) {
  return str.length == 4 && int.parse(str) >= 2020 && int.parse(str) <= 2030;
}

bool isValidHex(String str) {
  RegExp hexColor = RegExp(r'^#([0-9a-fA-F]{6})$');
  return hexColor.hasMatch(str);
}

bool isValidHeight(String str) {
  RegExp heightCm = RegExp(r'(1[5-8][0-9]|19[0-3])cm$');
  RegExp heightIn = RegExp(r'(59|[6-7][0-9]|7[0-6])in$');

  return heightCm.hasMatch(str) || heightIn.hasMatch(str);
}

bool isValidEyeColor(String str) {
  return ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].contains(str);
}

bool isValidPassport(String str) {
  return isNumeric(str) && str.length == 9;
}

bool isNumeric(String str) {
  if (str == null) {
    return false;
  }
  return double.tryParse(str) != null;
}
