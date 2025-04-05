//
//  ContentView.swift
//  Fitness
//
//  Created by Alexander Tsarapkine on 2024-12-23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        IngredientView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Ingredient.self, inMemory: true)
}
