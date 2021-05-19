import SwiftUI
import Combine
import UIKit

public struct ModalSheetMain: View {
    
    @State var offset = UIScreen.main.bounds.height
    @Binding var isShowing: Bool
    
    let heightToDisappear = UIScreen.main.bounds.height
    let cellHeight: CGFloat = 50
    let backgroundColor: Color
    
    var titleModal: String
    var titleButtonRight: String
    var titleButtonLeft: String
    
    var buttonsBar: Bool
    
    var textFieldModalView: TextFieldModalView
    
    public init(isShowing: Binding<Bool>,
                backgroundColor: Color = Color.white,
                titleModal: String,
                buttonsBar: Bool,
                titleButtonRight: String = "Adicionar",
                titleButtonLeft: String = "Cancelar",
                textFieldModalView: TextFieldModalView) {
        _isShowing = isShowing
        self.backgroundColor = backgroundColor
        self.titleModal = titleModal
        self.buttonsBar = buttonsBar
        self.titleButtonRight = titleButtonRight
        self.titleButtonLeft = titleButtonLeft
        self.textFieldModalView = textFieldModalView
    }
    
    func hide() {
        offset = heightToDisappear
        isShowing = false
    }
        
    var headerModalSheetCustom: some View {
        VStack() {
            Capsule()
                .frame(width: 50, height: 5)
                .foregroundColor(Color.gray)
                .padding(.top, 20)
            
            if buttonsBar {
                
                HStack {
                    Button(titleButtonLeft) {
                        hide()
                    }
                    Spacer()
                    Text(titleModal)
                        .font(.title3)
                        .bold()
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text(titleButtonRight)
                            .bold()
                    }
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
    
    var itemsView: some View {
        VStack {
            textFieldModalView
                .frame(height: cellHeight)
        }
    }
    
    var interactiveGesture: some Gesture {
        DragGesture()
            .onChanged({ (value) in
                if value.translation.height > 0 {
                    offset = value.location.y
                }
            })
            .onEnded({ (value) in
                let diff = abs(offset-value.location.y)
                if diff > 200 {
                    hide()
                }
                else {
                    offset = 0
                }
            })
    }
    
    
    var backgroundAreaView: some View {
        Group {
            if isShowing {
                BackgroundModalView {
                    self.hide()
                }
            }
        }
    }
    
    var sheetView: some View {
        VStack {
            Spacer()
            
            VStack {
                headerModalSheetCustom
                itemsView
            }
            .padding(.top, -UIScreen.main.bounds.height/4)
            .frame(height: UIScreen.main.bounds.height/2)
            .background(backgroundColor)
            .cornerRadius(15)
            .offset(y: offset)
            .gesture(interactiveGesture)
        }
    }
    
    var bodyContet: some View {
        ZStack {
            backgroundAreaView
            sheetView
        }
    }
    
    public var body: some View {
        Group {
            if isShowing {
                bodyContet
            }
        }
        .animation(.default)
        .onReceive(Just(isShowing), perform: { isShowing in
            offset = isShowing ? 0 : heightToDisappear
        })
    }
}

struct ModalSheetMain_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            ModalSheetMain(isShowing: .constant(true),
                            titleModal: "Adicionar Produto",
                            buttonsBar: true,
                            textFieldModalView: TextFieldModalView(title: "Nome", placeholder: "EX.: Arroz branco"))
        }
    }
}
//        VStack {
//                   ForEach(0..<items.count) { index in
//                       if index > 0 {
//                           Divider()
//                       }
//                    items[index]
//                   }
//               }
//               .padding()
