import SwiftUI
import Combine
import UIKit

public struct WithoutPriceModalView: View {
    @Binding var isShowing: Bool
    @State var valueItem: Double = 0.0
    @ObservedObject var shoppingListVM: ShoppingListViewModel
    var item: ProductItem?

    var bodyContet: some View {
        VStack {
            Text(
"""
Esse produto ainda não tem um preço atribuído.

Deseja adicionar o preço?
"""
            )
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.leading)
            .font(FontNameManager.CustomFont.textAreaComponentFont)
            CurrencyTextFieldModalView(valueFinal: $valueItem,
                                       hasTitle: false)
                .padding(.top, 10)
            Spacer()
            HStack {
                ButtonModalView(backgroundColor: .clear,
                                titleButton: "Pular",
                                actionButton: {
                                    self.jumpAction()
                                    self.isShowing.toggle()
                                })
                ButtonModalView(titleButton: "Salvar",
                                actionButton: {
                                    self.editPriceItem()
                                    self.isShowing.toggle()
                                })
            }
            .padding(.top)
            .padding(.bottom)
        }
        .frame(height: 300)
        .padding(.top, 10)
    }

    func editPriceItem() {
       guard let item = item else {return}
        var newItem = ItemList()
        newItem.name = item.name
        newItem.price = Float(valueItem)
        newItem.quantity = item.quantity
        newItem.isChecked = true
        shoppingListVM.update(updatedList: newItem, id: item.id)
        shoppingListVM.getAllItens()
    }

    func jumpAction() {
        self.valueItem = 0.0
        editPriceItem()
    }

    public var body: some View {
        VStack {
            Spacer()
            ModalView(isShowing: $isShowing,
                    keyboardRef: KeyboardResponder(),
                    isTitleLarge: true,
                    titleModal: "Produto sem preço",
                    contentBuilder: {bodyContet})
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }
}

struct WithoutPriceModalView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            WithoutPriceModalView(isShowing: .constant(true),
                                  shoppingListVM: ShoppingListViewModel())
        }
    }
}
