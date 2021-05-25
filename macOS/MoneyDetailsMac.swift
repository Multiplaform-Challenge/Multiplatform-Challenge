import SwiftUI

struct MoneyDetailsMac: View {
    let titleFont = Font.custom(FontNameManager.Poppins.regular, size: 17)
    let priceFont = Font.custom(FontNameManager.Poppins.medium, size: 20)
    var body: some View {
        VStack(spacing: 20) {
            HStack(alignment: .center) {
                Text("Orçamento")
                    .font(titleFont)
                Spacer()
                Text("R$250.00")
                    .font(priceFont)
            }
            .frame(maxHeight: 40)
            .foregroundColor(Color("TitleColor"))
            .padding()
            .background(RoundedRectangle(cornerRadius: 30).foregroundColor(Color("AccentColor")))

            ZStack {
                Rectangle()
                    .fill(Color("CardSecondColor"))
                    .cornerRadius(30)
                VStack(alignment: .center, spacing: 2) {
                    ZStack {
                        Rectangle()
                            .fill(Color("CardPrimaryColor"))
                            .cornerRadius(30)
                        HStack(alignment: .center) {
                            Text("Total da lista")
                                .font(titleFont)
                            Spacer()
                            Text("R$1000.00")
                                .font(Font.custom(FontNameManager.Poppins.bold, size: 20))
                        }
                        .padding()
                    }
                    HStack(alignment: .center) {
                        Text("Disponível")
                            .font(titleFont)
                        Spacer()
                        Text("R$100.00")
                            .font(priceFont)
                    }
                    .padding()
                }
            }
            .foregroundColor(Color("BackgroundColor"))
        }
        .padding()
        .frame(width: 300, height: 260, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}
