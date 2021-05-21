import SwiftUI

struct BudgetViewCell: View {

    @Binding var budget: String

    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()

    var body: some View {
        HStack {
            Text("Orçamento")
                .fixedSize()
            Spacer(minLength: 16)
            Text("R$")
                .fixedSize()
            TextField("Orçamento", text: $budget)
                .keyboardType(.decimalPad)
                .fixedSize()
                .multilineTextAlignment(.trailing)
//                .border(Color.blue)
        }
    }
}
