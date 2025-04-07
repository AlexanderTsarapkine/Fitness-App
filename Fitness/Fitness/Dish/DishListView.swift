//
//  ItemView.swift
//  Fitness
//
//  Created by Alexander Tsarapkine on 2025-04-04.
//

import SwiftUI


struct DishListView: View {
    @Environment(\.modelContext) private var modelContext
    var dish: Dish

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack(spacing: 8) {
                Text(dish.name)
                    .foregroundColor(.primary)
                    .font(.headline)
            }
            HStack(spacing: 8) {
                Text("\(dish.calories) kcal")
                Text("P: \(dish.protein)g")
                Text("C: \(dish.totalCarbohydrates)g")
            }
            .foregroundColor(.secondary)
            .font(.subheadline)
        }
    }
}
