import SwiftUI

struct ObjectiveViewCell: View {

    @Binding var objective: String

    var body: some View {
        HStack {
            Text("Objetivo")
            Spacer(minLength: 16)
            TextField("Objetivo", text: $objective)
                .multilineTextAlignment(.trailing)
//                .border(Color.blue)
        }
    }
}
