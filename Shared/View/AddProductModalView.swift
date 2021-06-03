import SwiftUI
import Combine

public struct AddProductModalView: View {
    var heightCell: CGFloat = 50.0
    var isEdit = false
    var item: ProductItem?

    @Binding var isShowing: Bool
    @State var nameItem: String = ""
    @State var quantityItem: Int = 0
    @State var priceItem: Double = 0.00
    @ObservedObject var shoppingListVM: ShoppingListViewModel

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
            Spacer()
            HStack {
                ButtonModalView(backgroundColor: .clear,
                                titleButton: "Cancelar",
                                actionButton: {
                                    self.isShowing.toggle()
                                })
                ButtonModalView(titleButton: isEdit ? "Salvar" : "Adicionar",
                                actionButton: isEdit ? editItem : addItem)
            }
            .padding(.top)
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
                    contentBuilder: {bodyContet}
            )
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }

    func addItem() {
        var newItem = ItemList()
        newItem.name = nameItem
        newItem.quantity = Int16(quantityItem)
        newItem.price = Float(priceItem)
        newItem.isChecked = false
        shoppingListVM.save(newItem: newItem)
        shoppingListVM.getAllItens()
        self.isShowing.toggle()
    }

    func editItem() {
        guard let item = item else {return}
        var newItem = ItemList()
        newItem.name = nameItem
        newItem.price = Float(priceItem)
        newItem.quantity = Int16(quantityItem)
        newItem.isChecked = item.isChecked
        shoppingListVM.update(updatedList: newItem, id: item.id)
        shoppingListVM.getAllItens()
        self.isShowing.toggle()
    }
}
