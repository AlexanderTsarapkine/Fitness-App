//
//  IngredientView.swift
//  Fitness
//
//  Created by Alexander Tsarapkine on 2025-04-04.
//
import SwiftUI
import SwiftData


struct DishView: View {
    @Query(sort: \Dish.name) private var dishes: [Dish]
    @Environment(\.modelContext) private var modelContext

    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredDishes) { dish in
                    NavigationLink {
                        EditDishView(dish: dish)
                    } label: {
                        DishListView(dish: dish)
                    }
                }
                .onDelete(perform: deleteDishes)
            }
            .searchable(text: $searchText)
            .navigationTitle("Dishes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        EditDishView(dish: nil)
                    } label: {
                        Text("Add Dish")
                    }
                }
            }
        }
    }

    private var filteredDishes: [Dish] {
        searchText.isEmpty
        ? dishes
        : dishes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }

    private func deleteDishes(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(dishes[index])
        }
        
//        for index in offsets {
//            let dish = dishes[index]
//            
//            // Iterate through the IngredientEntries for the dish
//            for ingredientEntry in dish.ingredients {
//                if ingredientEntry.ingredient.copy == true {
//                    modelContext.delete(ingredientEntry.ingredient)
//                }
//            }
//            
//            // Delete the dish after checking the associated ingredients
//            modelContext.delete(dish)
//        }
    }
}
