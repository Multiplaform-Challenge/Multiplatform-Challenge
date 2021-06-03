import SwiftUI
import Combine
import UIKit

public struct LimitModalView: View {
    @Binding var isShowing: Bool
    @ObservedObject var shoppingListVM: ShoppingListViewModel
    var item: ProductItem?

    var bodyContet: some View {
        VStack {
            Text(
"""
Com o item \(item?.name ?? "") a sua
lista passa R$\(String(format: "%.2f", calculate())) do
limite estabelecido de \(String(format: "%.2f",shoppingListVM.list.first?.budget ?? 0.00)).

Deseja remover o item?
"""
            )
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.leading)
            .font(FontNameManager.CustomFont.textAreaComponentFont)
            Spacer()
            HStack {
                ButtonModalView(backgroundColor: .clear,
                                titleButton: "Cancelar",
                                actionButton: {
                                    self.checkItem()
                                    self.isShowing.toggle()
                                })
                ButtonModalView(titleButton: "Remover",
                                actionButton: {
                                    self.removerItem()
                                    self.isShowing.toggle()
                                })
            }
            .padding(.top)
            .padding(.bottom)
        }
        .frame(height: 300)
    }

    func removerItem() {
        guard let item = item else {return}
        shoppingListVM.delete(item)
        shoppingListVM.getAllItens()
    }

    func checkItem() {
        guard let item = item else {return}
        var newItem = ItemList()
        newItem.name = item.name
        newItem.price = item.price
        newItem.quantity = item.quantity
        newItem.isChecked = true
        shoppingListVM.update(updatedList: newItem, id: item.id)
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

    public var body: some View {
        VStack {
            Spacer()
            ModalView(isShowing: $isShowing,
                    keyboardRef: KeyboardResponder(),
                    isTitleLarge: true,
                    titleModal: "No Limite",
                    contentBuilder: {bodyContet})
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }
}

struct LimitModalView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            LimitModalView(isShowing: .constant(true),
                           shoppingListVM: ShoppingListViewModel())
        }
    }
}
