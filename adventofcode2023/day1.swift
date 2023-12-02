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

func day1() {
    let path = "/Users/francescorubbo/fun/adventofcode2023/data/day1/input.txt"
    
    let data = try? NSString(contentsOfFile: path, encoding: String.Encoding.ascii.rawValue)
    
    var totalCalibration: Int = 0
    data?.enumerateLines({ (line, stop) -> () in
        totalCalibration += line.calibration
    })
    print(totalCalibration)
}
