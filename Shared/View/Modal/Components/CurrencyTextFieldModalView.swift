import SwiftUI

public struct CurrencyTextFieldModalView: View {
    @State var title: String = ""
    @State var text: String = ""
    @Binding var valueFinal: Double
    
    var value: Double {
        (Double(self.text) ?? 0.0) / 100
    }
    
    public var body: some View {
        
        let typing = Binding<String>(get: { () -> String in
            return String(format: "R$ %.2f", self.value)
        }) { (s) in
            var s = s
            s.removeAll { (c) -> Bool in
                !c.isNumber
            }
            self.text = s
            self.valueFinal = (Double(self.text) ?? 0.0) / 100
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

//struct CurrencyTextFieldModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrencyTextFieldModalView(title: "Preço")
//    }
//}
