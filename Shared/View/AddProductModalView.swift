import SwiftUI
import Combine
//import UIKit

public struct AddProductModalView: View {
    
    var isEditItem: Bool? = nil
    @Binding var isShowing: Bool
    @State var nameItem: String = ""
    @State var quantityItem: Int = 0
    @State var priceItem: Double = 0.00
    @StateObject var shoppingListVM: ShoppingListViewModel
    var heightCell: CGFloat = 50.0

    var bodyContet: some View {
        VStack {
            TextFieldModalView(nameText: $nameItem,
                               title: "Nome",
                               placeholder: "EX.: Arroz branco")
                .frame(height: heightCell)
            CurrencyTextFieldModalView(valueFinal: $priceItem,
                                       hasTitle: true,
                                       title: "Preço")
                .frame(height: heightCell)
            QuantityModalView(quantity: $quantityItem,
                              title: "Quantidade",
                              backgroundRectangleColor: Color( "ActionColorSecond"))

                .frame(height: heightCell)
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
                    actionButtonRight: addItem
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
        shoppingListVM.getAllItens()
    }
}
