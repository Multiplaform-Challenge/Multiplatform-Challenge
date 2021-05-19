import SwiftUI

public struct TextFieldModalView: View {
    
    let title: String
    let placeholder: String
    let titleFont: Font
    let foregrounColor: Color
    
    @State var nameProduct: String = ""
    
    public init(title: String,
                placeholder: String,
                titleFont: Font = Font.headline,
                foregrounColor: Color = Color.primary) {
        self.title = title
        self.placeholder = placeholder
        self.titleFont = titleFont
        self.foregrounColor = foregrounColor
    }
    
    var textFieldView: some View {
        HStack {
            Text(title)
                .font(.callout)
                .bold()
            Spacer()
            TextField(placeholder, text: $nameProduct)
                .frame(width: 200)
        }
        .padding(.horizontal)
    }
    
    public var body: some View {
        Group {
            textFieldView
                .foregroundColor(foregrounColor)
        }
    }
}

struct TextFieldModalView_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            Spacer()
            TextFieldModalView(title: "Nome", placeholder: "EX.: Arroz branco")
            Spacer()
        }
    }
}
