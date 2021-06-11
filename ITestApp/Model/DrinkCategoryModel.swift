//
//  CategoryDrinkModel.swift
//  ITestApp
//
//  Created by Stanislav on 09.06.2021.
//

import Foundation

struct DrinkCategory: Codable {
    let drinks: [Category]
}

struct Category: Codable, Hashable {
    let strCategory: String
}
