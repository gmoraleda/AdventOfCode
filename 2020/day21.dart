import 'dart:io';

main() {
  var path = 'input21.txt';

  final file = new File(path);

  var map = Map<String, Set<String>>();
  var ingredientsList = [];

  file.readAsStringSync().split('\n').forEach((e) {
    final ingredients = e.split(' \(').first.split(' ');
    ingredientsList.addAll(ingredients);
    final allergens = e
        .split('(contains ')
        .last
        .replaceAll(')', '')
        .replaceAll(',', '')
        .split(' ');

    allergens.forEach((allergen) {
      if (map[allergen] != null) {
        final newSet = map[allergen].intersection(ingredients.toSet());
        map[allergen] = newSet;
      } else {
        map[allergen] = ingredients.toSet();
      }
    });
  });

  var igredientsWithAllergens = Set<String>();
  for (var set in map.values) {
    igredientsWithAllergens = set.union(igredientsWithAllergens);
  }
  final safeIngredients =
      ingredientsList.toSet().difference(igredientsWithAllergens);

  print(
      'Part I: ${ingredientsList.where((element) => safeIngredients.contains(element)).length}');

  var allergenIngredientMap = Map<String, Set<String>>();
  while (map.values.any((element) => element.length > 1)) {
    for (var entry in map.entries) {
      if (entry.value.length == 1) {
        allergenIngredientMap[entry.key] = entry.value;
      }
    }

    for (var entry in map.entries) {
      for (var finalListEntry in allergenIngredientMap.entries) {
        map[entry.key] = map[entry.key].difference(finalListEntry.value);
      }
    }
  }

  allergenIngredientMap
      .addEntries(map.entries.where((element) => element.value.isNotEmpty));

  final sortedIngredients = allergenIngredientMap.keys.toList()..sort();
  print('Part II: ${sortedIngredients.map((element) {
    return allergenIngredientMap[element].first;
  }).join(',')}');
}
