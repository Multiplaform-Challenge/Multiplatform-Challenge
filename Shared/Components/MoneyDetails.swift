//
//  MoneyDetails.swift
//  SwiftUITests
//
//  Created by José Mateus Azevedo on 14/05/21.
//

import SwiftUI

struct MoneyDetails: View {
    let titleFont = Font.custom(FontNameManager.Poppins.bold, size: 27)
    let priceFont = Font.custom(FontNameManager.Poppins.regular, size: 17)
    @StateObject var shoppingListVM: ShoppingListViewModel = ShoppingListViewModel()
    var orcamentoTest = 250.0

    func calculateSum() -> Double {
        var totalSum: Double = 0.00
        shoppingListVM.itens.forEach { item in
            if item.isChecked {
                totalSum += Double((item.price * Float(item.quantity)))
            }
        }
        return totalSum
    }

    func calculateRest() -> Double {
        let rest: Double = orcamentoTest - calculateSum()
        return rest
    }

    var body: some View {
        HStack(spacing: 5) {
            VStack(alignment: .center) {
                Text("R$250.00")
                    .font(titleFont)
                    .frame(maxWidth: .infinity)
                Text("Orçamento")
                    .font(priceFont)
            }
            .frame(maxHeight: .infinity)
            .padding()
            .background(RoundedRectangle(cornerRadius: 30).foregroundColor(Color("AccentColor")))

            ZStack {
                Rectangle()
                    .fill(Color("CardSecondColor"))
                    .cornerRadius(30)
                VStack(alignment: .center, spacing: 2) {
                    ZStack {
                        Rectangle()
                            .fill(Color("CardPrimaryColor"))
                            .cornerRadius(30)
                        VStack(alignment: .center) {
                            Text("R$\(String(format: "%.2f", calculateSum()))")
                                .font(titleFont)
                                .frame(maxWidth: .infinity)
                            Text("Total da lista")
                                .font(priceFont)
                        }
                        .padding()
                    }
                    VStack(alignment: .center) {
                        Text("R$\(String(format: "%.2f", calculateRest()))")
                            .font(Font.custom(FontNameManager.Poppins.bold, size: 20))
                            .frame(maxWidth: .infinity)
                        Text("Disponível")
                            .font(priceFont)
                    }
                    .padding(.bottom)
                }
            }
            .foregroundColor(.white)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color("BackgroundColor")))
        .frame(width: 400, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct MoneyDetails_Previews: PreviewProvider {
    static var previews: some View {
        MoneyDetails(shoppingListVM: ShoppingListViewModel())
    }
}
