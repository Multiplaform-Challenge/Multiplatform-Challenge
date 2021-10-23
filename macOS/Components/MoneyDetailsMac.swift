import SwiftUI

struct MoneyDetailsMac: View {
    @ObservedObject var shoppingListVM: ShoppingListViewModel
    let titleFont = Font.custom(FontNameManager.Poppins.regular, size: 17)
    let priceFont = Font.custom(FontNameManager.Poppins.medium, size: 20)

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
        let rest: Double = (shoppingListVM.list.first?.budget ?? 0.00) - calculateSum()
        return rest
    }

    var body: some View {
        VStack(spacing: 20) {
            HStack(alignment: .center) {
                Text("Total da lista")
                    .font(titleFont)
                Spacer()
                Text("R$\(String(format: "%.2f", calculateSum()))")
                    .font(priceFont)
            }
            .frame(maxHeight: 40)
            .foregroundColor(Color("TitleColor"))
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
                        HStack(alignment: .center) {
                            Text("Orçamento")
                                .font(titleFont)
                            Spacer()
                            Text("R$\(String(format: "%.2f", shoppingListVM.list.first?.budget ?? 250.00))")
                                .font(Font.custom(FontNameManager.Poppins.bold, size: 20))
                        }
                        .padding()
                    }
                    HStack(alignment: .center) {
                        Text("Disponível")
                            .font(titleFont)
                        Spacer()
                        Text("R$\(String(format: "%.2f", calculateRest()))")
                            .font(priceFont)
                            .foregroundColor(calculateRest() < 0 ? .red : .white)
                    }
                    .padding()
                }
            }
            .foregroundColor(Color("BackgroundColor"))
        }
        .padding()
        .frame(width: 300, height: 260, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}
