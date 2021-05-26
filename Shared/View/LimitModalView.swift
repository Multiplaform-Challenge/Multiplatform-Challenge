import SwiftUI
import Combine
import UIKit

public struct LimitModalView: View {
    @Binding var isShowing: Bool

    var bodyContet: some View {
        VStack {
            Text(
"""
Com o item Arroz branco a sua lista passa R$26,00 do limite estabelecido de R$250.

Deseja remover o item?
"""
            )
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.leading)
            .font(FontNameManager.CustomFont.textAreaComponentFont)
        }
        .padding(.top, 10)
        .padding(.bottom, 50)
    }

    func removerItem() {

    }

    public var body: some View {
        VStack {
            Spacer()
            ModalView(isShowing: $isShowing,
                    keyboardRef: KeyboardResponder(),
                    isTitleLarge: true,
                    titleModal: "No Limite",
                    titleButtonLeft: "Cancelar",
                    titleButtonRight: "Remover",
                    contentBuilder: {bodyContet},
                    actionButtonRight: removerItem)
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }
}

struct LimitModalView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            LimitModalView(isShowing: .constant(true))
        }
    }
}
