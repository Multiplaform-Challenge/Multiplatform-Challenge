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
            BudgetViewCell(budget: $shoppingList.budget)
        }
    }

    var body: some View {
        return view
            .navigationTitle("Configurações")
            .listStyle(PlainListStyle())
    }

}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView(shoppingList: ShoppingListDemo())
//    }
//}
