//
//  ItemDetailedField.swift
//  Fitness
//
//  Created by Alexander Tsarapkine on 2025-04-04.
//


import SwiftUI
import SwiftUI

struct IngredientDetailedView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var ingredient: Ingredient
    @Binding var isSheetPresented: Bool
    
    @State private var localIngredient: Ingredient
    private var new: Bool

    init(ingredient: Ingredient, isSheetPresented: Binding<Bool>, new: Bool) {
        self._ingredient = Bindable(ingredient)
        self._isSheetPresented = isSheetPresented
        self.new = new

        self.localIngredient = Ingredient(name: String(ingredient.name))
        self.localIngredient.serving = ingredient.serving
        self.localIngredient.protein = ingredient.protein
        self.localIngredient.totalCarbohydrates = ingredient.totalCarbohydrates
        self.localIngredient.totalFats = ingredient.totalFats
        self.localIngredient.unit = ingredient.unit
        
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Basic Info")) {
                    TextField("Name", text: $localIngredient.name)
                }

                Section(header: Text("Serving Information")) {
                    HStack {
                        Text("Serving Size").bold()
                        Spacer()
                        nutrientRow(label: "Serving", text: $localIngredient.serving)

                    }
                    Picker("Unit", selection: $localIngredient.unit) {
                        ForEach(Units.allCases, id: \.self) { unit in
                            Text(unit.rawValue).tag(unit)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 80)
                }

                Section(header: Text("Nutrition Information")) {
                    nutrientRow(label: "Protein", text: $localIngredient.protein)
                    nutrientRow(label: "Carbohydrates", text: $localIngredient.totalCarbohydrates)
                    nutrientRow(label: "Fats", text: $localIngredient.totalFats)

                    HStack {
                        Text("Calories").bold()
                        Spacer()
                        Text("\(localIngredient.calories)")
                            .frame(width: 80, alignment: .trailing)
                        Text("kcal")
                            .frame(width: 40)
                    }
                    .padding(.vertical, 8)
                }
            }
            .onChange(of: localIngredient.protein) {localIngredient.updateCalories()}
            .onChange(of: localIngredient.totalCarbohydrates) {localIngredient.updateCalories() }
            .onChange(of: localIngredient.totalFats) {localIngredient.updateCalories() }
            .onChange(of: localIngredient.serving) {localIngredient.updateCalories() }
            
            .navigationBarTitle("\(new == true ? "Add" : "Edit") Ingredient", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                if !localIngredient.name.isEmpty {
                    ingredient.name = localIngredient.name
                }
                if localIngredient.serving > 0 {
                    ingredient.serving = localIngredient.serving
                }
                if localIngredient.protein >= 0 {
                    ingredient.protein = localIngredient.protein
                }
                if localIngredient.totalCarbohydrates >= 0 {
                    ingredient.totalCarbohydrates = localIngredient.totalCarbohydrates
                }
                if localIngredient.totalFats >= 0 {
                    ingredient.totalFats = localIngredient.totalFats
                }
                ingredient.unit = localIngredient.unit
                ingredient.updateCalories()
                
                if new {
                    modelContext.insert(ingredient)
                } else {
                    // TODO: update all recipes that contain ingredient? <-- eek
                }
                isSheetPresented = false
            }
            .disabled(localIngredient.name.trimmingCharacters(in: .whitespaces).isEmpty)
            .foregroundColor(localIngredient.name.trimmingCharacters(in: .whitespaces).isEmpty ? .gray : .blue)
            )
        }
    }

    private func nutrientRow(label: String, text: Binding<Int32>) -> some View {
        HStack {
            Text(label).bold()
            Spacer()
            TextField("", text: text.asString())
                .multilineTextAlignment(.trailing)
                .keyboardType(.numberPad)
                .frame(width: 80)
        }
    }
    
}

extension Binding where Value == Int32 {
    func asString() -> Binding<String> {
        Binding<String>(
            get: { String(self.wrappedValue) },
            set: {
                self.wrappedValue = Int32($0) ?? 0
            }
        )
    }
}
