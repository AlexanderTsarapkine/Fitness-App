//
//  Item.swift
//  Fitness
//
//  Created by Alexander Tsarapkine on 2024-12-23.
//

//TODO: eventually migrate to use apple "Nutrition Type Identifiers"

import Foundation
import SwiftData

enum Units: String, Codable, CaseIterable {
    case g, ml
}

@Model
final class Ingredient {
    var name: String
    
    var calories: Int32 = 0
    var totalCarbohydrates: Int32 = 0
    var protein: Int32 = 0
    var totalFats: Int32 = 0
    var serving: Int32 = 1
    var unit: Units = Units.g
    
    init(name: String) {
        self.name = name
    }
    
    func updateCalories() {
        self.calories = calcCalories()
    }
    
    private func calcCalories() -> Int32 {
        return totalCarbohydrates * 4 + protein * 4 + totalFats * 9
    }
}
