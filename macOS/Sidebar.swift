import SwiftUI

struct Sidebar: View {
    let titleFont = Font.custom(FontNameManager.Poppins.bold, size: 22)
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Café da manhã")
                    .font(titleFont)
//                    .border(Color.red)
                Spacer()
                Button(action: {}, label: {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 20))
                        .foregroundColor(Color("AccentColor"))
                })
                .buttonStyle(BorderlessButtonStyle())
            }
            .padding(.horizontal, 20)

            MoneyDetailsMac()
            Spacer()
        }
    }
}
