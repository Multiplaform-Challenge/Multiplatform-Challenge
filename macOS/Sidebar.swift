import SwiftUI

struct Sidebar: View {
    let titleFont = Font.custom(FontNameManager.Poppins.bold, size: 22)
    @ObservedObject var shoppingListVM: ShoppingListViewModel
    @State var showModal = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Café da manhã")
                    .font(titleFont)
                Spacer()
                Button(action: { showModal = true}, label: {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 20))
                        .foregroundColor(Color("AccentColor"))
                })
                .buttonStyle(BorderlessButtonStyle())
            }
            .padding(.horizontal, 20)
            .sheet(isPresented: $showModal, content: { SettingsModalView(showModal: $showModal) })
            MoneyDetailsMac(shoppingListVM: shoppingListVM)
            Spacer()
        }
    }
}
