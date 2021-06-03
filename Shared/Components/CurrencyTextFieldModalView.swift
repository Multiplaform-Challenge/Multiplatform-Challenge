import SwiftUI

public struct CurrencyTextFieldModalView: View {
    var title: String
    @Binding var valueFinal: Double
    var hasTitle: Bool

    public init(valueFinal: Binding<Double>,
                hasTitle: Bool,
                title: String = "") {
        _valueFinal = valueFinal
        self.hasTitle = hasTitle
        self.title = title
    }

    public var body: some View {
        if hasTitle {
            HStack {
                Text(title)
                    .font(FontNameManager.CustomFont.titleComponentFont)
                Spacer()
                #if os(iOS)
                TextField("\(String(format: "R$ %.2f", valueFinal))", text: Binding(get: { self.format(value: valueFinal) }, set: { self.valueFinal = self.format(text: $0) }))
                    .keyboardType(.numberPad)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .multilineTextAlignment(.trailing)
                    .font(FontNameManager.CustomFont.textfieldComponentFont)
                    .foregroundColor(valueFinal == 0.0 ? Color("PlaceholderColor") : Color("TitleColor"))
                #else
                TextField("\(String(format: "R$ %.2f", valueFinal))", text: Binding(get: { self.format(value: valueFinal) }, set: { self.valueFinal = self.format(text: $0) }))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .multilineTextAlignment(.trailing)
                    .font(FontNameManager.CustomFont.textfieldComponentFont)
                    .foregroundColor(valueFinal == 0.0 ? Color("PlaceholderColor") : Color("TitleColor"))
                #endif
            }
        } else {
            HStack {
                #if os(iOS)
                TextField("\(String(format: "R$ %.2f", valueFinal))", text: Binding(get: { self.format(value: valueFinal) }, set: { self.valueFinal = self.format(text: $0) }))
                    .keyboardType(.numberPad)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .font(Font.custom(FontNameManager.Poppins.medium, size: 30))
                    .foregroundColor(valueFinal == 0.0 ? Color("PlaceholderColor") : Color("TitleColor"))
                #else
                TextField("\(String(format: "R$ %.2f", valueFinal))", text: Binding(get: { self.format(value: valueFinal) }, set: { self.valueFinal = self.format(text: $0) }))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .font(Font.custom(FontNameManager.Poppins.medium, size: 30))
                    .foregroundColor(valueFinal == 0.0 ? Color("PlaceholderColor") : Color("TitleColor"))
                #endif
            }
        }
    }

    func format(value: Double) -> String {
        return String(format: "R$ %.2f", value)
    }

    func format(text: String) -> Double {
        var auxText = text
        auxText.removeAll { (char) -> Bool in
            !char.isNumber
        }
        return (Double(auxText) ?? 0.0) / 100
    }
}
