import SwiftUI
import Combine

public struct WithoutPriceMac: View {
    @Binding var showModal: Bool
    @ObservedObject var shoppingListVM: ShoppingListViewModel
    @State var valueItem: Double = 0.0
    var item: ProductItem?

    public var body: some View {
        let titleFont = Font.custom(FontNameManager.Poppins.bold, size: 22)
        let textFont = Font.custom(FontNameManager.Poppins.medium, size: 20)
        VStack {
            HStack {
                Text("Produto sem preço")
                    .font(titleFont)
                Spacer()
            }
            .padding(.bottom, 35)

            Text(
"""
Esse produto ainda não tem um preço atribuído.

Deseja adicionar o preço?
"""
            )
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.leading)
            .font(textFont)
            CurrencyTextFieldModalView(valueFinal: $valueItem,
                                       hasTitle: false)

            HStack {
                ButtonModalView(foregrounColor: .black, backgroundColor: .clear,
                                titleButton: "Pular",
                                actionButton: {
                                                jumpAction()
                                                showModal = false
                                                })
                ButtonModalView(foregrounColor: .black, backgroundColor: Color("AccentColor"),
                                titleButton: "Salvar",
                                actionButton: {
                                                editPriceItem()
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
}
