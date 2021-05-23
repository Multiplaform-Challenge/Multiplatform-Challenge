import SwiftUI

public struct CurrencyTextFieldModalView: View {
    var title: String
    @State var valueText: String = ""
    @Binding var valueFinal: Double
    var hasTitle: Bool

    public init(valueFinal: Binding<Double>,
                hasTitle: Bool,
                title: String = "") {
        _valueFinal = valueFinal
        self.hasTitle = hasTitle
        self.title = title
    }

    var value: Double {
        (Double(self.valueText) ?? 0.0) / 100
    }

    public var body: some View {
        let typing = Binding<String>(get: { () -> String in
            return String(format: "R$ %.2f", self.value)
        }) { (text) in
            var text = text
            text.removeAll { (char) -> Bool in
                !char.isNumber
            }
            self.valueText = text
            self.valueFinal = (Double(self.valueText) ?? 0.0) / 100
        }
        if hasTitle {
            HStack {
                Text(title)
                    .font(FontNameManager.CustomFont.titleComponentFont)
                Spacer()
                TextField("R$ 0.00", text: typing).keyboardType(.numbersAndPunctuation)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .multilineTextAlignment(.trailing)
                    .font(FontNameManager.CustomFont.textfieldComponentFont)
                    .foregroundColor(value == 0.0 ? Color("PlaceholderColor") : Color("TitleColor"))
            }
        } else {
            HStack {
                TextField("R$ 0.00", text: typing).keyboardType(.numbersAndPunctuation)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .font(Font.custom(FontNameManager.Poppins.medium, size: 30))
                    .foregroundColor(value == 0.0 ? Color("PlaceholderColor") : Color("TitleColor"))
            }
        }
    }
}
