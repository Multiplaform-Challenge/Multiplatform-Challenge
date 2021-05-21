import SwiftUI

public struct CurrencyTextFieldModalView: View {
    @State var title: String = ""
    @State var valueText: String = ""
    @Binding var valueFinal: Double
    
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
        HStack {
            Text(title)
                .font(.callout)
                .bold()
            Spacer()
            TextField("R$ 0.00", text: typing).keyboardType(.numbersAndPunctuation)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .multilineTextAlignment(.trailing)
        }
        .padding(.horizontal)
    }
}
