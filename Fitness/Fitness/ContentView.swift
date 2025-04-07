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
        
        
        TabView {
            Tab("Ingredients", systemImage: "carrot.fill") {
                IngredientView()
            }
            Tab("Dishes", systemImage: "fork.knife.circle.fill") {
                DishView()
            }
            Tab("Today", systemImage: "sun.horizon.fill") {
                IngredientView()
            }
            Tab("Progress", systemImage: "person.crop.circle.fill") {
                IngredientView()
            }
            Tab("Exercises", systemImage: "figure.strengthtraining.traditional.circle.fill") {
                IngredientView()
            }
            
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Ingredient.self, inMemory: true) // TODO: eventually change inMemory to false.... or smth so persistent
        .modelContainer(for: Dish.self, inMemory: true)

}
