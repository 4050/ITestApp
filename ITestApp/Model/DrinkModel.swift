//
//  Drink.swift
//  ITestApp
//
//  Created by Stanislav on 09.06.2021.
//

import Foundation

struct DrinkModel: Codable {
    let drinks: [Drink]
}

struct Drink: Codable, Hashable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
}
