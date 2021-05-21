import SwiftUI

public struct BackgroundModalView: View {
    let opacity: Double
    let callback: (() -> ())?

    public init(opacity: Double = 0.5,
                callback: (() -> ())? = nil) {
        self.opacity = opacity
        self.callback = callback
    }

    var backgroundView: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(Color.gray)
            .opacity(self.opacity)
            .onTapGesture {
                callback?()
            }
            .ignoresSafeArea()
    }

    public var body: some View {
        backgroundView
    }
}

struct BackgroundModalView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundModalView()
    }
}
