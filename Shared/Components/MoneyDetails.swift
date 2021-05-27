//
//  MoneyDetails.swift
//  SwiftUITests
//
//  Created by José Mateus Azevedo on 14/05/21.
//

import SwiftUI

struct MoneyDetails: View {
    @StateObject var shoppingListVM: ShoppingListViewModel
    let titleFont = Font.custom(FontNameManager.Poppins.bold, size: 27)
    let priceFont = Font.custom(FontNameManager.Poppins.regular, size: 17)
    var body: some View {
        HStack(spacing: 5) {
            VStack(alignment: .center) {
                Text("R$\(String(format: "%.2f", shoppingListVM.list.first?.budget ?? 250.00))")
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
                            Text("R$1000.00")
                                .font(titleFont)
                                .frame(maxWidth: .infinity)
                            Text("Total da lista")
                                .font(priceFont)
                        }
                        .padding()
                    }
                    VStack(alignment: .center) {
                        Text("R$100.00")
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
