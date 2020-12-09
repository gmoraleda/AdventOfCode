import Foundation
do {
  let content = try String(contentsOfFile: "input.txt")
  let intArray = content.components(separatedBy: "\n").compactMap { Int($0) }

  let dict = intArray.reduce(into: [Int: Int]()) {
    $0[$1] = 2020 - $1
  }

  for entry in dict {
    for number in intArray {
      if intArray.contains(entry.value - number) {
        print(entry.key)
        print(number)
        print(entry.value - number)
        exit(-1)
      }
    }
  }
}
