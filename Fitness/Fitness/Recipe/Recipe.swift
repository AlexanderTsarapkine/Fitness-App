//
//  Dish.swift
//  Fitness
//
//  Created by Alexander Tsarapkine on 2025-04-04.
//


import Foundation
import SwiftData

@Model
final class Recipe {
    var name: String
    var calories: Int32 = 0
    var totalCarbohydrates: Int32 = 0
    var protein: Int32 = 0
    var totalFats: Int32 = 0
    var ingredients: [IngredientEntry] = []

    init(name: String) {
        self.name = name
    }
    
    func updateNutrition() {
        self.totalCarbohydrates = 0
        self.protein = 0
        self.totalFats = 0
        
        for ingredientEntry in self.ingredients {
            self.totalCarbohydrates += Int32(round(Double(ingredientEntry.ingredient.totalCarbohydrates) * ingredientEntry.multiplier))
            self.protein += Int32(round(Double(ingredientEntry.ingredient.protein) * ingredientEntry.multiplier))
            self.totalFats += Int32(round(Double(ingredientEntry.ingredient.totalFats) * ingredientEntry.multiplier))
        }
        
        self.calories = self.totalCarbohydrates * 4 + self.protein * 4 + self.totalFats * 9
    }
    
    func addIngredient(_ ingredient: Ingredient, amount: Double) {
        let entry = IngredientEntry(ingredient: ingredient, multiplier: amount)
        ingredients.append(entry)
        updateNutrition()
    }
    
    func removeIngredient(at index: Int) {
        if ingredients.indices.contains(index) {
            ingredients.remove(at: index)
            updateNutrition()
        }
    }
}

@Model
final class IngredientEntry {
    var ingredient: Ingredient
    var multiplier: Double
    
    init(ingredient: Ingredient, multiplier: Double) {
        self.ingredient = ingredient
        self.multiplier = multiplier
    }
}
