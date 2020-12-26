import 'dart:io';

main() {
  var path = 'input22.txt';

  final file = new File(path);

  final decks = file
      .readAsStringSync()
      .split('\n\n')
      .map((e) => {e.split('\n').sublist(1).map((e) => int.parse(e)).toList()});

  var p1Deck = decks.first.toList().first;
  var p2Deck = decks.last.toList().first;

  while (p1Deck.isNotEmpty && p2Deck.isNotEmpty) {
    final p1Card = p1Deck.removeAt(0);
    final p2Card = p2Deck.removeAt(0);

    if (p1Card > p2Card) {
      p1Deck.addAll([p1Card, p2Card]);
    } else {
      p2Deck.addAll([p2Card, p1Card]);
    }
  }

  final winningDeck = p1Deck.length > p2Deck.length ? p1Deck : p2Deck;

  var score = 0;
  for (var i = winningDeck.length; i > 0; i--) {
    score += winningDeck[winningDeck.length - i] * i;
  }
  print(score);
}
