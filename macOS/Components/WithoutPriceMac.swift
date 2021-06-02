import SwiftUI
import Combine

public struct WithoutPriceMac: View {
    @Binding var showModal: Bool
    @ObservedObject var shoppingListVM: ShoppingListViewModel
    @State var valueItem: Double = 0.0
    var item: ProductItem?

    public var body: some View {
        let textFont = Font.custom(FontNameManager.Poppins.regular, size: 17)
        VStack {
            HStack {
                Text("Produto sem preço")
                    .font(FontNameManager.CustomFont.headerLargeTitleComponentFont)
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
            .font(FontNameManager.CustomFont.textAreaComponentFont)
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
        shoppingListVM.name = item.name
        shoppingListVM.quantity = Int16(item.quantity)
        shoppingListVM.price = Float(valueItem)
        shoppingListVM.isChecked = true
        shoppingListVM.upDate(id: item.id)
        shoppingListVM.getAllItens()
    }

    func jumpAction() {
        self.valueItem = 0.0
        editPriceItem()
    }
}
