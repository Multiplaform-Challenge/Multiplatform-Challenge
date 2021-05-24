import SwiftUI
import Combine
import UIKit

public struct AddProductModalView: View {
    @Binding var isShowing: Bool
    @State var nameItem: String = ""
    @State var quantityItem: Int = 0
    @State var priceItem: Double = 0.00
    @StateObject private var shoppingListVM = ShoppingListViewModel()

    var bodyContet: some View {
        VStack {
            TextFieldModalView(nameText: $nameItem,
                               title: "Nome",
                               placeholder: "EX.: Arroz branco")
                .frame(height: 50)
            CurrencyTextFieldModalView(title: "Preço",
                                       valueFinal: $priceItem)
                .frame(height: 50)
            QuantityModalView(quantity: $quantityItem,
                              title: "Quantidade",
                              backgroundRectangleColor: Color( "ActionColorSecond"))
                .frame(height: 50)
        }
        .padding()
    }

    public var body: some View {
        VStack {
            Spacer()
            ModalView(isShowing: $isShowing,
                    keyboardRef: KeyboardResponder(),
                    isTitleLarge: false,
                    titleModal: "Adicionar Produto",
                    titleButtonLeft: "Cancelar",
                    titleButtonRight: "Adicionar",
                    contentBuilder: {bodyContet},
                    action: addItem
            )
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }

    func addItem() {
        shoppingListVM.name = nameItem
        shoppingListVM.quantity = Int16(quantityItem)
        shoppingListVM.prince = Float(priceItem)
        shoppingListVM.isChecked = false
        shoppingListVM.save()
    }
}

struct AddProductModalView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            AddProductModalView(isShowing: .constant(true))
        }
    }
}
