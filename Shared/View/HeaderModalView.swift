import SwiftUI

public struct HeaderModalView: View {
    var titleModal: String
    var isTitleLarge: Bool
    
    public init(titleModal: String,
                isTitleLarge: Bool) {
        self.titleModal = titleModal
        self.isTitleLarge = isTitleLarge
    }
    
    public var body: some View {
        VStack {
            Capsule()
                .frame(width: 50, height: 5)
                .foregroundColor(Color.gray)
                .padding(.top, 20)
            if !isTitleLarge {
                HStack {
                    Spacer()
                    Text(titleModal)
                        .font(.body)
                        .bold()
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)
            } else {
                HStack {
                    Text(titleModal)
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 30)
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
}

struct HeaderModalView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderModalView(titleModal: "Adicionar produto",
                        isTitleLarge: true)
    }
}
