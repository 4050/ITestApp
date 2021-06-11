//
//  StringPicker.swift
//  ITestApp
//
//  Created by Stanislav on 10.06.2021.
//

import Foundation

class StringPicker {
    static func searchString(_ string: String) -> String {
       var replacingString = string.replacingOccurrences(of: " ", with: "_")
        replacingString = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=\(replacingString)"
            return replacingString
        }
}
