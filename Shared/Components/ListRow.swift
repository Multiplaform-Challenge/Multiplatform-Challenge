import SwiftUI

struct ListRow: View {

    let item: ItemList
    @State var checkState:Bool = false

    var checkboxFieldView: some View {
         Button(action: {
                self.checkState = !self.checkState
            }) {
            if checkState {
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
                Text("R$ \(String(format: "%.2f", item.price))")
                    .font(FontNameManager.CustomFont.titleComponentFont)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).foregroundColor(self.checkState ? Color("ActionColorSecond") : Color.white).shadow(radius: checkState ? 0 : 1))

    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(item: ItemList(name: "Macarrão", price: 3.35, quantity: 5, isChecked: false))
    }
}
