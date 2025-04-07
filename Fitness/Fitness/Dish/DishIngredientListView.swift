//
//  DishIngredientListView.swift
//  Fitness
//
//  Created by Alexander Tsarapkine on 2025-04-06.
//

import SwiftUI

struct DishIngredientListView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var ingredientEntry: IngredientEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(ingredientEntry.ingredient.name)
                .foregroundColor(.primary)
                .font(.headline)

            HStack(spacing: 12) {
                Text("\(Int(Double(ingredientEntry.ingredient.calories) * ingredientEntry.multiplier)) kcal")
                Text("P: \(String(format: "%.1f", Double(ingredientEntry.ingredient.protein) * ingredientEntry.multiplier))g")
                Text("C: \(String(format: "%.1f", Double(ingredientEntry.ingredient.totalCarbohydrates) * ingredientEntry.multiplier))g")
                Text("Serving: \(String(format: "%.1f", Double(ingredientEntry.ingredient.serving) * ingredientEntry.multiplier))\(ingredientEntry.ingredient.unit)")

            }
            .font(.subheadline)
            .foregroundColor(.secondary)

            HStack(spacing: 12) {
                Text("x\(String(format: "%.2f", ingredientEntry.multiplier))")
                    .font(.caption)
                    .foregroundColor(.gray)

                Slider(value: $ingredientEntry.multiplier, in: 0...10, step: 0.1)
            }
            
        }
        .padding(.vertical, 6)
    }
}
