import SwiftUI

public struct ButtonModalView: View {
    let foregrounColor: Color
    let backgroundColor: Color
    let titleButton: String
    let actionButton: (() -> ())?

    public init(foregrounColor: Color = Color("TitleColor"),
                backgroundColor: Color = Color("ActionColorPrimary"),
                titleButton: String,
                actionButton: (() -> ())? = nil) {
        self.foregrounColor = foregrounColor
        self.backgroundColor = backgroundColor
        self.titleButton = titleButton
        self.actionButton = actionButton
    }

    var buttonView: some View {
        Button(action: {
            actionButton?()
        }) {
            Text(titleButton)
                .fontWeight(.bold)
                .font(.callout)
                .frame(width: 100, height: 20)
                .padding()
                .background(backgroundColor)
                .foregroundColor(foregrounColor)
                .cornerRadius(40)
        }
    }

    public var body: some View {
        Group {
            buttonView
                .foregroundColor(foregrounColor)
        }
    }
}

struct ButtonModalView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            ButtonModalView(titleButton: "Adicionar")
            Spacer()
        }
    }
}
