//
//  MacModalView.swift
//  MultiplatformChallenge (macOS)
//
//  Created by David Augusto on 25/05/21.
//

import SwiftUI

struct SettingsModalView: View {

    @State var budget = 1.0
    @State var objective = "Ir pro ceu"
    @ObservedObject var shoppingListVM: ShoppingListViewModel
    @Binding var showModal: Bool

    func save() {
        shoppingListVM.updateMoneyDatails(shoppingListVM.list.first!, newList: (shoppingListVM.budget, shoppingListVM.objective))
        shoppingListVM.getAllItens()
    }

    var body: some View {
        let titleFont = Font.custom(FontNameManager.Poppins.bold, size: 22)
        let textFont = Font.custom(FontNameManager.Poppins.medium, size: 17)
        VStack {
            HStack {
                Text("Configurações")
                    .font(titleFont)
                Spacer()
            }
            .padding(.bottom, 35)

            ObjectiveViewCell(objective: $shoppingListVM.objective)
            BudgetViewCell(budget: $shoppingListVM.budget)
            HStack {
                ButtonModalView(foregrounColor: .black, backgroundColor: .clear, titleButton: "Cancelar", actionButton: {showModal = false})
                ButtonModalView(foregrounColor: .black,
                                backgroundColor: Color("AccentColor"),
                                titleButton: "Salvar",
                                actionButton: {
                                    save()
                                    showModal.toggle()
                                })
            }
            .padding(.top, 40)

        }
        .padding(.horizontal, 30)
        .buttonStyle(BorderlessButtonStyle())
        .frame(width: 430, height: 300, alignment: .center)
        .background(Color.white)
        .foregroundColor(Color.black)
        .font(textFont)
        .textFieldStyle(PlainTextFieldStyle())
    }
}
