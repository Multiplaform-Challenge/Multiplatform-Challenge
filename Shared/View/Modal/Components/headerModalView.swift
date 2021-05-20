import SwiftUI

public struct headerModalView: View {
    
    var titleModal: String
    var titleButtonRight: String
    var titleButtonLeft: String
    
    let leftAction: (() -> ())?
    let rightAction: (() -> ())?
    
    var isTitleLarge: Bool
    
    public init(titleModal: String,
                isTitleLarge: Bool,
                titleButtonLeft: String = "Cancelar",
                titleButtonRight: String = "Adicionar",
                leftAction: (() -> ())? = nil,
                rightAction: (() -> ())? = nil) {
        self.titleModal = titleModal
        self.titleButtonRight = titleButtonRight
        self.titleButtonLeft = titleButtonLeft
        self.leftAction = leftAction
        self.rightAction = rightAction
        self.isTitleLarge = isTitleLarge
    }
    
    public var body: some View {
        VStack() {
            
            Capsule()
                .frame(width: 50, height: 5)
                .foregroundColor(Color.gray)
                .padding(.top, 20)
            
            if isTitleLarge {
                
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

struct headerModalView_Previews: PreviewProvider {
    static var previews: some View {
        headerModalView(titleModal: "Adicionar produto",
                        isTitleLarge: true)
    }
}
