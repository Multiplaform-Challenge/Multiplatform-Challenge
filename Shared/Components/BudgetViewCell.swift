import SwiftUI

struct BudgetViewCell: View {

    @Binding var budget: Double

    @State var showSeparator = false
    let budgetCharLimit = 15

    var body: some View {
        HStack {
            Text("Orçamento")
                .fixedSize()
            Spacer(minLength: 16)
            TextField("Orçamento", text: Binding(get: { self.format(value: budget) }, set: { self.budget = self.format(text: $0) }))
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
//                .border(Color.blue)
        }
    }

    func format(value: Double) -> String {
        // for presentation
        // replace "." with decimal separator
//        print("Value: \(value)")
        let separator = Locale.current.decimalSeparator ?? "."
        var formattedValue = String(format: "%f", value)
            .replacingOccurrences(of: ".", with: separator)
            .reversed()
            .drop(while: {$0 == "0"})
            .reversed()
            .map(String.init)
            .joined()
        if !showSeparator {
            formattedValue.removeLast()
        }
        return "R$ \(formattedValue)"
    }

    func format(text: String) -> Double {
//        print("Text: \(text)")
        if text.count >= budgetCharLimit {
            return budget
        }
        let separator = Locale.current.decimalSeparator ?? "."
        let formattedText = text
            .replacingOccurrences(of: separator, with: ".")
            .replacingOccurrences(of: "R", with: "")
            .replacingOccurrences(of: "$", with: "")
            .replacingOccurrences(of: " ", with: "")
//        print(formattedText)
        if formattedText.contains(".") {
            showSeparator = true
        } else {
            showSeparator = false
        }
        return Double(formattedText) ?? 0
    }
}
