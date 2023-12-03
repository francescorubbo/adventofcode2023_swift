//
//  day1.swift
//  adventofcode2023
//
//  Created by Francesco Rubbo on 12/2/23.
//

import Foundation

extension String {
    var calibration: Int {
        let results = self.matches(of: /(\d)/)
        let firstDigit = results.first?.output.0 ?? ""
        let lastDigit = results.last?.output.0 ?? ""
        return Int("\(firstDigit)\(lastDigit)")!
    }
}

let mapping: [String: String] = [
    "zero": "0",
    "one": "1",
    "two": "2",
    "three": "3",
    "four": "4",
    "five": "5",
    "six": "6",
    "seven": "7",
    "eight": "8",
    "nine": "9"
]

extension String {
    var extremeSpelledDigits: (Optional<String>, Optional<String>) {
        var leftMost: Optional<String> = nil
        var leftMostIndex: String.Index = self.endIndex
        var rightMost: Optional<String> = nil
        var rightMostIndex: String.Index = self.startIndex
        for spelled in Array(mapping.keys) + Array(mapping.values) {
            if let leftRange = self.range(of: spelled) {
                if leftRange.upperBound < leftMostIndex {
                    leftMost = spelled
                    leftMostIndex = leftRange.upperBound
                }
            }
            if let rightRange = self.range(of: spelled, options: String.CompareOptions.backwards) {
                if rightRange.lowerBound > rightMostIndex {
                    rightMost = spelled
                    rightMostIndex = rightRange.lowerBound
                }
            }
        }
        return (leftMost, rightMost)
    }
}

func replaceSpelled(inputString: String) -> String {
    var outputString = inputString
    let (leftMost, rightMost) = inputString.extremeSpelledDigits
    if leftMost != nil {
        if let leftRange = outputString.range(of: leftMost!) {
            outputString = outputString.replacingCharacters(in: leftRange, with: mapping[leftMost!] ?? leftMost!)
        }
    }
    if rightMost != nil {
        if let rightRange = outputString.range(of: rightMost!,  options: String.CompareOptions.backwards) {
            outputString = outputString.replacingCharacters(in: rightRange, with: mapping[rightMost!] ?? rightMost!)
        }
    }
    return outputString
}

func day1(doReplaceSpelled: Bool = false) {
    let path = "/Users/francescorubbo/fun/adventofcode2023/data/day1/input.txt"
    
    let data = try? NSString(contentsOfFile: path, encoding: String.Encoding.ascii.rawValue)
    
    var totalCalibration: Int = 0
    data?.enumerateLines({ (line, stop) -> () in
        var _line = line
        if doReplaceSpelled {
            _line = replaceSpelled(inputString: _line)
        }
        totalCalibration += _line.calibration
    })
    print(totalCalibration)
}
