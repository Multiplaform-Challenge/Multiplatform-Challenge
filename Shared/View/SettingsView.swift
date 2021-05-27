//
//  SettingsView.swift
//  MultiplatformChallenge (iOS)
//
//  Created by Rodrigo Matos Aguiar on 19/05/21.
//

import SwiftUI

struct SettingsView: View {

    @StateObject var shoppingListVM: ShoppingListViewModel

    private var view: some View {
        List {
            ObjectiveViewCell(objective: $shoppingListVM.objective)
            BudgetViewCell(budget: $shoppingListVM.budget)
        }
        .onDisappear(perform: {
            save()
        })
    }

    var body: some View {
        return view
            .navigationTitle("Configurações")
            .listStyle(PlainListStyle())
    }

    func save() {
        shoppingListVM.updateMoneyDatails(shoppingListVM.list.first!, newList: (shoppingListVM.budget, shoppingListVM.objective))
        shoppingListVM.getAllItens()
    }

}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView(shoppingList: ShoppingListDemo())
//    }
//}
