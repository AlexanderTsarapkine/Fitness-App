//
//  DishAddIngredientView.swift
//  Fitness
//
//  Created by Alexander Tsarapkine on 2025-04-06.
//

import SwiftUI
import SwiftData

struct DishAddIngredientView: View {
    @Query(sort: \Ingredient.name) private var ingredients: [Ingredient]
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Binding var dish: Dish
    
    @State private var searchText = ""
    @State private var isSheetPresented = false
    @State private var selectedIngredient: Ingredient = Ingredient(name: "New Ingredient")
    @State private var isNew: Bool = true;

    var body: some View {
        NavigationStack{
            List {
                ForEach(filteredIngredients) { ingredient in
                    Button(action: {
                        dish.ingredients.append(IngredientEntry(ingredient: ingredient, multiplier: 1)) // clone removed
                        dish.updateNutrition()
                                      
                        dismiss()
                    }) {
                        IngredientListView(ingredient: ingredient)
                    }
                }
//                .onDelete(perform: deleteIngredients)
            }
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem {
                    Button("New Ingredient") {
                        selectedIngredient = Ingredient(name: "New Ingredient")
                        isNew = true;
                        isSheetPresented.toggle()
                    }
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                IngredientDetailedView(ingredient: selectedIngredient, isSheetPresented: $isSheetPresented, new: isNew)
            }
        }
    }
    
    private var filteredIngredients: [Ingredient] {
        if searchText.isEmpty {
            return ingredients
        } else {
            return ingredients.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        
//        if searchText.isEmpty {
//            return ingredients.filter { !$0.copy }
//        } else {
//            return ingredients.filter { !$0.copy && $0.name.lowercased().contains(searchText.lowercased()) }
//        }
    }

//    private func deleteIngredients(at offsets: IndexSet) {
//        for index in offsets {
//            modelContext.delete(ingredients[index])
//        }
//    }
}
