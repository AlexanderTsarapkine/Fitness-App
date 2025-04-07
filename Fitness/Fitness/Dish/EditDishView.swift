//
//  DishDetailedView.swift
//  Fitness
//
//  Created by Alexander Tsarapkine on 2025-04-05.
//
// https://developer.apple.com/documentation/swiftdata/adding-and-editing-persistent-data-in-your-app

import SwiftUI

struct EditDishView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let dish: Dish?
    
    private var editorTitle: String {
        dish == nil ? "Add Dish" : "Edit Dish"
    }
    
    @State var localDish: Dish = Dish(name:"")
    
    var body: some View {
        HStack {
            Form {
                Section(header: Text("Basic Info")) {
                    TextField("Name", text: $localDish.name)
                }
                Section(header: Text("Nutrition Information")) {
                    nutrientRow(label: "Calories", text: $localDish.calories)
                    nutrientRow(label: "Protein", text: $localDish.protein)
                    nutrientRow(label: "Carbohydrates", text: $localDish.totalCarbohydrates)
                    nutrientRow(label: "Fats", text: $localDish.totalFats)
                }
                Section(header: Text("Ingredients")) {
                    List {
                        ForEach($localDish.ingredients) { $ingredientEntry in
                            DishIngredientListView(ingredientEntry: $ingredientEntry)
                                .onChange(of: ingredientEntry.multiplier) {
                                    localDish.updateNutrition()
                                }
                        }
                        .onDelete(perform: deleteIngredients)
                        NavigationLink {
                            DishAddIngredientView(dish: $localDish)
                        } label: {
                            Label("Add Ingredient", systemImage: "plus.circle")
                                .foregroundColor(.accentColor)
                        }
                        
                    }

                    
                }
                
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(editorTitle)
            }
            ToolbarItem(placement: .confirmationAction) {
                if dish == nil {
                    Button("Clear") {
                        localDish = Dish(name: "")
                    }
                }
                
            }
            ToolbarItem(placement: .confirmationAction) {
                if dish == nil {
                    Button("Add") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                    .disabled(localDish.name.trimmingCharacters(in: .whitespaces).isEmpty)
                    .foregroundColor(localDish.name.trimmingCharacters(in: .whitespaces).isEmpty ? .gray : .blue)
                }
            }
        }
        .onAppear {
            if let dish {
                localDish = dish
            }
        }
    }
    
    private func deleteIngredients(at offsets: IndexSet) {
//        for index in offsets {
//            let entry = localDish.ingredients[index]
//            if entry.ingredient.copy == true {
//                modelContext.delete(entry.ingredient)
//            }
//        }
        
        
        // old v, new ^
        localDish.ingredients.remove(atOffsets: offsets)
        localDish.updateNutrition()
    }
    
    private func nutrientRow(label: String, text: Binding<Int32>) -> some View {
        HStack {
            Text(label).bold()
            Spacer()
            Text("\(text.wrappedValue)")
                .frame(width: 80, alignment: .trailing)
        }    
    }
    
    private func save() {
        if dish == nil {
            modelContext.insert(localDish)
        }
    }
    
}
