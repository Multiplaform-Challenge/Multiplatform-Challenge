import SwiftUI
import Combine

public struct LimitModalMac: View {
    @Binding var showModal: Bool
    @ObservedObject var shoppingListVM: ShoppingListViewModel
    var item: ProductItem?

    public var body: some View {
        let titleFont = Font.custom(FontNameManager.Poppins.bold, size: 22)
        let textFont = Font.custom(FontNameManager.Poppins.medium, size: 20)
        VStack {
            HStack {
                Text("No Limite")
                    .font(titleFont)
                Spacer()
            }
            .padding(.bottom, 35)

            Text(
"""
Com o item \(item?.name ?? "") a sua lista passa R$\(String(format: "%.2f", calculate())) do limite estabelecido de \(String(format: "%.2f",shoppingListVM.list.first?.budget ?? 0.00)).

Deseja remover o item?
"""
            )
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.leading)
            .font(textFont)

            HStack {
                ButtonModalView(foregrounColor: .black, backgroundColor: .clear,
                                titleButton: "Cancelar",
                                actionButton: {
                                                checkItem()
                                                showModal = false
                                                })
                ButtonModalView(foregrounColor: .black, backgroundColor: Color("AccentColor"),
                                titleButton: "Remover",
                                actionButton: {
                                                removerItem()
                                                showModal = false
                                                })
            }
            .padding(.top, 40)

        }
        .padding(.horizontal, 30)
        .buttonStyle(BorderlessButtonStyle())
        .frame(width: 430, height: 420, alignment: .center)
        .background(Color.white)
        .foregroundColor(Color.black)
        .font(textFont)
        .textFieldStyle(PlainTextFieldStyle())
    }

    func removerItem() {
        guard let item = item else {return}
        shoppingListVM.delete(item)
        shoppingListVM.getAllItens()
    }

    func checkItem() {
        guard let item = item else {return}
        shoppingListVM.name = item.name
        shoppingListVM.quantity = Int16(item.quantity)
        shoppingListVM.price = Float(item.price)
        shoppingListVM.isChecked = true
        shoppingListVM.update(id: item.id)
        shoppingListVM.getAllItens()
    }

    func calculate() -> Double {
        var totalSum: Double = 0.00
        shoppingListVM.itens.forEach { item in
            if item.isChecked {
                totalSum += Double((item.price * Float(item.quantity)))
            }
        }
        guard let item = item else {return 0}
        totalSum += Double(item.price * Float(item.quantity))
        let rest = totalSum - Double(shoppingListVM.list.first?.budget ?? 0.00)
        return rest
    }
}
