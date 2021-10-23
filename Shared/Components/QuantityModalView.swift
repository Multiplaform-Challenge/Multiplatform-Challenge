import SwiftUI

public struct QuantityModalView: View {
    let title: String
    let titleFont: Font
    let foregrounColor: Color
    let backgroundRectangleColor: Color

    @Binding var quantity: Int

    public init(quantity: Binding<Int>,
                title: String,
                titleFont: Font = Font.headline,
                foregrounColor: Color = Color("TitleColor"),
                backgroundRectangleColor: Color) {
        _quantity = quantity
        self.title = title
        self.titleFont = titleFont
        self.foregrounColor = foregrounColor
        self.backgroundRectangleColor = backgroundRectangleColor
    }

    var textFieldView: some View {
        HStack {
            Text(title)
                .font(FontNameManager.CustomFont.titleComponentFont)
            Spacer()
            HStack {
                Button(action: {
                    if quantity > 1 {
                        quantity -= 1
                    }
                }) {
                    Image(systemName: "minus")
                }
                Text("\(quantity)")
                    .font(Font.custom(FontNameManager.Poppins.regular, size: 24))
                Button(action: {
                    quantity += 1
                }) {
                    Image(systemName: "plus")
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .multilineTextAlignment(.trailing)
        }
    }

    var selectorQuantityView: some View {
        HStack {
            ForEach(1..<6) { index in
                Button(action: {
                    quantity = 2 * index
                }) {
                    ZStack {
                        Rectangle()
                            .fill(backgroundRectangleColor)
                            .frame(width: 50, height: 30)
                        Text("\(2 * index)")
                            .font(FontNameManager.CustomFont.boxQuantityComponentFont)
                            .frame(width: 50, height: 30, alignment: .center)
                            .foregroundColor(foregrounColor)
                    }
                }
            }
        }
    }

    public var body: some View {
        Group {
            textFieldView
                .foregroundColor(foregrounColor)
            selectorQuantityView
                .padding(.top, 20)
        }
    }
}
