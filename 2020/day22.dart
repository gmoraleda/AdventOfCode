import 'dart:io';

main() {
  var path = 'input22.txt';
  final file = new File(path);
  final players = file.readAsStringSync().split('\n\n').toList();

  var p1Deck =
      players.first.split('\n').sublist(1).map((e) => int.parse(e)).toList();
  var p2Deck =
      players.last.split('\n').sublist(1).map((e) => int.parse(e)).toList();

  partOne(List.from(p1Deck), List.from(p2Deck));

  final winningDeck = partTwo(p1Deck, p2Deck) == 1 ? p1Deck : p2Deck;
  printScore(winningDeck);
}

void partOne(List<int> p1Deck, List<int> p2Deck) {
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
  printScore(winningDeck);
}

int partTwo(List<int> p1Deck, List<int> p2Deck) {
  var seenGames = Set<String>();
  while (p1Deck.isNotEmpty && p2Deck.isNotEmpty) {
    final game = p1Deck.join() + '-' + p2Deck.join();

    if (seenGames.contains(game)) {
      return 1;
    }

    seenGames.add(game);

    final p1Card = p1Deck.removeAt(0);
    final p2Card = p2Deck.removeAt(0);

    if (p1Card <= p1Deck.length && p2Card <= p2Deck.length) {
      final subgameWinner = partTwo(List.from(p1Deck.sublist(0, p1Card)),
          List.from(p2Deck.sublist(0, p2Card)));

      if (subgameWinner == 1) {
        p1Deck.add(p1Card);
        p1Deck.add(p2Card);
      } else {
        p2Deck.add(p2Card);
        p2Deck.add(p1Card);
      }
    } else {
      if (p1Card > p2Card) {
        p1Deck.add(p1Card);
        p1Deck.add(p2Card);
      } else {
        p2Deck.add(p2Card);
        p2Deck.add(p1Card);
      }
    }
  }
  return p1Deck.isEmpty ? 2 : 1;
}

void printScore(List<int> winningDeck) {
  var score = 0;
  for (var i = winningDeck.length; i > 0; i--) {
    score += winningDeck[winningDeck.length - i] * i;
  }
  print(score);
}
