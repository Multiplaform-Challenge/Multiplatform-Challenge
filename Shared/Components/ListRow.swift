import SwiftUI

struct ListRow: View {

    let item: ProductItem
    @State var checkState:Bool = false
    @Binding var isShowingWithoutPriceModal: Bool
    var action: () -> Void
    @StateObject var shoppingListVM: ShoppingListViewModel

    func checkItem() {
        shoppingListVM.name = item.name
        shoppingListVM.quantity = Int16(item.quantity)
        shoppingListVM.price = Float(item.price)
        shoppingListVM.isChecked = checkState
        shoppingListVM.upDate(id: item.id)
        shoppingListVM.getAllItens()
    }

    var checkboxFieldView: some View {
         Button(action: {
            if item.price == 0.0 && !item.isChecked {
                action()
                self.isShowingWithoutPriceModal.toggle()
            } else {
                self.checkState = !item.isChecked
                checkItem()
            }
        }) {
            if item.isChecked {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("AccentColor"))
            } else {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .shadow(radius: 2)
            }
        }
        .foregroundColor(Color.white)
        .buttonStyle(PlainButtonStyle())
    }

    var body: some View {
        HStack {
            checkboxFieldView
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(FontNameManager.CustomFont.titleComponentFont)
                Text("\(item.quantity) unidades")
                    .font(Font.custom(FontNameManager.Poppins.regular, size: 17))
                    .foregroundColor(Color("TextColor"))
            }
            Spacer()
            VStack {
                Text("R$ \(String(format: "%.2f", (item.price*Float(item.quantity))))")
                    .font(FontNameManager.CustomFont.titleComponentFont)
                Text("\(item.quantity) x R$\(String(format: "%.2f", item.price))")
                    .font(Font.custom(FontNameManager.Poppins.regular, size: 12))
                    .foregroundColor(Color("TextColor"))
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).foregroundColor(self.item.isChecked ? Color("ActionColorSecond") : Color.white).shadow(radius: self.item.isChecked ? 0 : 1))

    }
}
