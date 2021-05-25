import SwiftUI

struct MoneyDetailsMac: View {
    let titleFont = Font.custom(FontNameManager.Poppins.regular, size: 17)
    let priceFont = Font.custom(FontNameManager.Poppins.medium, size: 20)
    var body: some View {
        VStack(spacing: 5) {
            HStack(alignment: .center) {
                Text("Orçamento")
                    .font(titleFont)
                Text("R$250.00")
                    .font(priceFont)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxHeight: .infinity)
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
                            Text("R$1000.00")
                                .font(Font.custom(FontNameManager.Poppins.bold, size: 20))
                                .frame(maxWidth: .infinity)
                        }
                        .padding()
                    }
                    HStack(alignment: .center) {
                        Text("Disponível")
                            .font(titleFont)
                        Text("R$100.00")
                            .font(priceFont)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.bottom)
                }
            }
            .foregroundColor(Color("BackgroundColor"))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color("BackgroundColor")))
        .frame(width: 400, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}
