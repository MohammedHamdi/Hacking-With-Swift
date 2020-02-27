import UIKit
/*
let name = "3bass"

for letter in name {
    print("Give me a \(letter)")
}


let letter = name[name.index(name.startIndex, offsetBy: 3)]
print(letter)


extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
    
    // remove a prefix if it exists
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else {return self}
        return String(self.dropFirst(prefix.count))
    }
    
    // remove a suffix if it exists
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else {return self}
        return String(self.dropLast(suffix.count))
    }
    
    var capitalizedFirst: String {
        guard let firstLetter = self.first else {return ""}
        return firstLetter.uppercased() + self.dropFirst()
    }
    
    func containsAny(of array: [String]) -> Bool {
        for item in array {
            if self.contains(item) {
                return true
            }
        }
        return false
    }
}

let newLetter = name[2]
print(newLetter)

let password = "12345"
password.hasPrefix("123")
password.hasSuffix("345")

password.deletingPrefix("12")

let weather = "it's going to rain"
print(weather.capitalized)

weather.capitalizedFirst

let input = "Swift is like Objective-C without the C"
input.contains("Swift")

let languages = ["Python", "Ruby", "Swift"]
languages.contains("Swift")

input.containsAny(of: languages)

languages.contains(where: input.contains)

let string = "This is a test string"
let attributes: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36)
]

let attributedString = NSMutableAttributedString(string: string)
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))
*/

extension String {
    func withPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else {return prefix + self}
        return self
    }
    
    var isNumeric: Bool {
        if let _ = Double(self) {
            return true
        } else {
            return false
        }
    }
    
    var lines: [String] {
        return self.components(separatedBy: "\n")
    }
}

let example = "pet"
example.withPrefix("car")
example.withPrefix("pet")

let number = "12"
number.isNumeric

let linesExample = "this\nis\na\ntest"
linesExample.lines
