import SwiftUI

struct ListRow: View {

    let item: ItemList

    var body: some View {
        HStack {
            CheckboxFieldView()
            Text(String(item.quantity))
            Text(item.name)
            Spacer()
            Text("R$ \(String(format: "%.2f", item.price))")
        }.padding()
    }
}

struct CheckboxFieldView : View {

    @State var checkState:Bool = false

    var body: some View {
         Button(action: {
                self.checkState = !self.checkState }) {
            HStack(alignment: .top, spacing: 10) {
                   Rectangle()
                            .fill(self.checkState ? Color.gray : Color.black)
                            .frame(width:20, height:20, alignment: .center)
                            .cornerRadius(10)
            }
        }
        .foregroundColor(Color.white)
        .buttonStyle(PlainButtonStyle())
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(item: ItemList(name: "Macarrão", price: 3.35, quantity: 5, isChecked: false))
    }
}
