import SwiftUI
import Combine
import UIKit

public struct ModalView<Content: View>: View {
    @ObservedObject var keyboardRef: KeyboardResponder
    @State var offset = UIScreen.main.bounds.height
    @Binding var isShowing: Bool

    let heightToDisappear = UIScreen.main.bounds.height
    let cellHeight: CGFloat = 50
    let backgroundColor: Color

    var isTitleLarge: Bool
    var titleModal: String
    var titleButtonRight: String
    var titleButtonLeft: String
    let content: Content

    public init(isShowing: Binding<Bool>,
                keyboardRef: KeyboardResponder,
                backgroundColor: Color = Color.white,
                isTitleLarge: Bool,
                titleModal: String,
                titleButtonLeft: String = "Cancelar",
                titleButtonRight: String = "Adicionar",
                @ViewBuilder contentBuilder: () -> Content) {
        _isShowing = isShowing
        self.keyboardRef = keyboardRef
        self.backgroundColor = backgroundColor
        self.isTitleLarge = isTitleLarge
        self.titleModal = titleModal
        self.content = contentBuilder()
        self.titleButtonLeft = titleButtonLeft
        self.titleButtonRight = titleButtonRight
    }

    func hide() {
        offset = heightToDisappear
        isShowing = false
    }

    var dragGestureDismissModal: some Gesture {
        DragGesture()
            .onChanged({ (value) in
                if value.translation.height > 0 {
                    offset = value.location.y
                }
            })
            .onEnded({ (value) in
                let diff = abs(offset-value.location.y)
                if diff > 100 {
                    hide()
                } else {
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
                HeaderModalView(titleModal: titleModal,
                                isTitleLarge: isTitleLarge)
                content
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                HStack {
                    ButtonModalView(backgroundColor: .clear,
                                    titleButton: titleButtonLeft,
                                    actionButton: hide)
                    Spacer()
                    ButtonModalView(titleButton: titleButtonRight)
                }
                .frame(width: UIScreen.main.bounds.width * 0.9)
                .padding(.top, 30)
                Text("").frame(height:  keyboardRef.isActive ? keyboardRef.currentHeight : 50)
            }
            .padding(.horizontal)
            .background(backgroundColor)
            .cornerRadius(15)
            .offset(y: offset)
            .gesture(dragGestureDismissModal)
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
//        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        .animation(.default)
        .onReceive(Just(isShowing), perform: { isShowing in
            offset = isShowing ? 0 : heightToDisappear
        })
    }
}
