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
    
    var calories: Int32 = 0 // convert to object / extend object
    var totalCarbohydrates: Int32 = 0
    var protein: Int32 = 0
    var totalFats: Int32 = 0
    var serving: Int32 = 1
    var unit: Units = Units.g
//    var copy: Bool = false
    
    init(name: String) {
        self.name = name
    }
    
//    func clone() -> Ingredient {
//        let copyIngredient = Ingredient(name: self.name)
//        copyIngredient.protein = self.protein
//        copyIngredient.totalCarbohydrates = self.totalCarbohydrates
//        copyIngredient.totalFats = self.totalFats
//        copyIngredient.serving = self.serving
//        copyIngredient.unit = self.unit
//        copyIngredient.copy = true
//        copyIngredient.updateCalories()
//        return copyIngredient
//    }
    
    func updateCalories() {
        self.calories = calcCalories()
    }
    
    private func calcCalories() -> Int32 {
        return totalCarbohydrates * 4 + protein * 4 + totalFats * 9
    }
}
