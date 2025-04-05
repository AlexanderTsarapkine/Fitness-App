//
//  IngredientView.swift
//  Fitness
//
//  Created by Alexander Tsarapkine on 2025-04-04.
//

import SwiftUI
import SwiftData

struct IngredientView: View {
    @Query(sort: \Ingredient.name) private var ingredients: [Ingredient]
    @Environment(\.modelContext) private var modelContext
    
    @State private var searchText = ""
    @State private var isSheetPresented = false
    @State private var selectedIngredient: Ingredient = Ingredient(name: "New Ingredient")
    @State private var isNew: Bool = true;

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredIngredients) { ingredient in
                    Button(action: {
                        selectedIngredient = ingredient
                        isNew = false;
                        isSheetPresented.toggle()
                    }) {
                        IngredientListView(ingredient: ingredient)
                    }
                }
                .onDelete(perform: deleteIngredients)
            }
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem {
                    Button("Add Ingredient") {
                        selectedIngredient = Ingredient(name: "New Ingredient")
                        isNew = true;
                        isSheetPresented.toggle()
                    }
                }
            }
            .navigationTitle("Ingredients")
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
    }

    private func deleteIngredients(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(ingredients[index])
        }
    }
}
