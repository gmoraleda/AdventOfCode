import Foundation

// 3-4 j: tjjj

struct PasswordPolicy {
  let min: Int
  let max: Int
  let match: String
  let password: String

  var isValid: Bool {
    let array = Array(password)
    let a = String(array[min - 1])
    let b = String(array[max - 1])

    return (a == match || b == match) && a != b
  }
}

do {
  let content = try String(contentsOfFile: "input2.txt")
  let strings = content.components(separatedBy: "\n")

  let policies = strings.compactMap { element -> PasswordPolicy? in
    let components = element.components(separatedBy: " ")
    if components.count == 3 {
      let first = components.first?.components(separatedBy: "-")

      let min = Int(first!.first!)!
      let max = Int(first!.last!)!

      let match = String(components[1].first!)

      let password = components.last!

      return PasswordPolicy(min: min, max: max, match: match, password: password)
    }
    return nil
  }
  print(policies.filter {
    $0.isValid
  }.count)
}
