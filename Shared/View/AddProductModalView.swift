import SwiftUI
import Combine
import UIKit

public struct AddProductModalView: View {
    @Binding var isShowing: Bool
    @State var nameItem: String = ""
    @State var quantityItem: Int = 0
    @State var priceItem: Double = 0.0

    var bodyContet: some View {
        VStack {
            TextFieldModalView(nameText: $nameItem,
                               title: "Nome",
                               placeholder: "EX.: Arroz branco")
                .frame(height: 50)
            CurrencyTextFieldModalView(title: "Preço",
                                       valueFinal: $priceItem)
                .frame(height: 50)
            QuantityModalView(quantity: $quantityItem,
                              title: "Quantidade",
                              backgroundRectangleColor: Color( "ActionColorSecond"))
                .frame(height: 50)
//            testar os State's
//            Text(nameItem)
//            Text("\(quantityItem)")
//            Text("\(priceItem)")
        }
        .padding()
    }

    public var body: some View {
        VStack {
            Spacer()
            ModalView(isShowing: $isShowing,
                    keyboardRef: KeyboardResponder(),
                    isTitleLarge: false,
                    titleModal: "Adicionar Produto",
                    titleButtonLeft: "Cancelar",
                    titleButtonRight: "Adicionar",
                    contentBuilder: {bodyContet})
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }
}

struct AddProductModalView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            AddProductModalView(isShowing: .constant(true))
        }
    }
}
