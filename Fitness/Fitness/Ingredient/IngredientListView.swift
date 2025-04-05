//
//  ItemView.swift
//  Fitness
//
//  Created by Alexander Tsarapkine on 2025-04-04.
//

import SwiftUI


struct IngredientListView: View {
    @Environment(\.modelContext) private var modelContext
    var ingredient: Ingredient

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack(spacing: 8) {
                Text(ingredient.name)
                    .foregroundColor(.primary)
                    .font(.headline)
            }
            HStack(spacing: 8) {
                Text("\(ingredient.calories) kcal")
                Text("P: \(ingredient.protein)g")
                Text("C: \(ingredient.totalCarbohydrates)g")
                Text("Serving: \(ingredient.serving)\(ingredient.unit)")
            }
            .foregroundColor(.secondary)
            .font(.subheadline)
        }
    }
}
