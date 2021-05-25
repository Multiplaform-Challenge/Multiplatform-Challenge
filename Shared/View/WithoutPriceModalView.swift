import SwiftUI
import Combine
import UIKit

public struct WithoutPriceModalView: View {
    @Binding var isShowing: Bool
    @State var valueItem: Double = 0.0

    var bodyContet: some View {
        VStack {
            Text(
"""
Esse produto ainda não tem um preço atribuído.

Deseja adicionar o preço?
"""
            )
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.leading)
            .font(FontNameManager.CustomFont.textAreaComponentFont)
            CurrencyTextFieldModalView(valueFinal: $valueItem,
                                       hasTitle: false)
                .padding(.top, 30)
        }
        .padding(.top, 10)
    }

    func addPriceItem() {

    }

    public var body: some View {
        VStack {
            Spacer()
            ModalView(isShowing: $isShowing,
                    keyboardRef: KeyboardResponder(),
                    isTitleLarge: true,
                    titleModal: "Produto sem preço",
                    titleButtonLeft: "Pular",
                    titleButtonRight: "Salvar",
                    contentBuilder: {bodyContet}, action: addPriceItem)
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }
}

struct WithoutPriceModalView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            WithoutPriceModalView(isShowing: .constant(true))
        }
    }
}
