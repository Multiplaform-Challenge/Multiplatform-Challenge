//
//  SettingsView.swift
//  MultiplatformChallenge (iOS)
//
//  Created by Rodrigo Matos Aguiar on 19/05/21.
//

import SwiftUI

struct SettingsView: View {

    @ObservedObject var shoppingList: ShoppingListDemo

    private var view: some View {
        List {
            ObjectiveViewCell(objective: $shoppingList.objective)
            BudgetViewCell(budget: Binding(get: { self.format(value: shoppingList.budget)
            }, set: {
                self.shoppingList.budget = self.format(text: $0)
            }))
        }
    }

    var body: some View {
        return view
            .navigationTitle("Configurações")
            .listStyle(PlainListStyle())
    }

    @State var showSeparator = false

    func format(value: Double) -> String {
        // for presentation
        // replace "." with decimal separator
//        print("Value: \(value)")
        let separator = Locale.current.decimalSeparator ?? "."
        var formattedValue = String(format: "%f", value)
            .replacingOccurrences(of: ".", with: separator)
            .reversed()
            .drop(while: {$0 == "0"})
            .reversed()
            .map(String.init)
            .joined()
        if !showSeparator {
            formattedValue.removeLast()
        }
        return "R$ \(formattedValue)"
    }

    let budgetCharLimit = 15

    func format(text: String) -> Double {
//        print("Text: \(text)")
        if text.count >= budgetCharLimit {
            return shoppingList.budget
        }
        let separator = Locale.current.decimalSeparator ?? "."
        let formattedText = text
            .replacingOccurrences(of: separator, with: ".")
            .replacingOccurrences(of: "R", with: "")
            .replacingOccurrences(of: "$", with: "")
            .replacingOccurrences(of: " ", with: "")
//        print(formattedText)
        if formattedText.contains(".") {
            showSeparator = true
        } else {
            showSeparator = false
        }
        return Double(formattedText) ?? 0
    }

}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(shoppingList: ShoppingListDemo())
    }
}
