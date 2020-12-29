main() {
  final publicKey1 = 10212254;
  final publicKey2 = 12577395;

  final loopSizeDoor = calculateLoopSize(publicKey1);
  final loopSizeCard = calculateLoopSize(publicKey2);

  print(calculateKey(publicKey2, loopSizeDoor));
  print(calculateKey(publicKey1, loopSizeCard));
}

int calculateKey(int subjectNumber, int loopSize) {
  var initialSubject = 1;

  for (var i = 0; i < loopSize; i++) {
    initialSubject *= subjectNumber;
    initialSubject = initialSubject % 20201227;
  }
  return initialSubject;
}

int calculateLoopSize(int key) {
  var initialSubject = 1;
  final subjectNumber = 7;
  var loopSize = 0;
  while (true) {
    initialSubject *= subjectNumber;
    initialSubject = initialSubject % 20201227;
    loopSize++;

    if (initialSubject == key) {
      return loopSize;
    }
  }
}
