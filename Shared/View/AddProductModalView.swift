import SwiftUI
import Combine
import UIKit

public struct AddProductModalView: View {
    var heightCell: CGFloat = 50.0
    var isEdit = false
    var item: ProductItem?
    @Binding var isShowing: Bool
    @State var nameItem: String = ""
    @State var quantityItem: Int = 0
    @State var priceItem: Double = 0.00
    @StateObject var shoppingListVM: ShoppingListViewModel

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
        .onAppear {
            self.nameItem = item?.name ?? ""
            self.quantityItem = Int(item?.quantity ?? 0)
            self.priceItem = Double(item?.price ?? 0.00)
        }
        .padding()
    }

    public var body: some View {
        VStack {
            Spacer()
            ModalView(isShowing: $isShowing,
                    keyboardRef: KeyboardResponder(),
                    isTitleLarge: false,
                    titleModal: isEdit ? "Editar Produto" : "Adicionar Produto",
                    titleButtonLeft: "Cancelar",
                    titleButtonRight: isEdit ? "Salvar" : "Adicionar",
                    contentBuilder: {bodyContet},
                    actionButtonRight: isEdit ? editItem : addItem
            )
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }

    func addItem() {
        shoppingListVM.name = nameItem
        shoppingListVM.quantity = Int16(quantityItem)
        shoppingListVM.price = Float(priceItem)
        shoppingListVM.isChecked = false
        shoppingListVM.save()
        shoppingListVM.getAllItens()
    }

    func editItem() {
        guard let item = item else {return}
        shoppingListVM.name = nameItem
        shoppingListVM.quantity = Int16(quantityItem)
        shoppingListVM.price = Float(priceItem)
        shoppingListVM.isChecked = item.isChecked
        shoppingListVM.upDate(id: item.id)
        shoppingListVM.getAllItens()
    }
}
