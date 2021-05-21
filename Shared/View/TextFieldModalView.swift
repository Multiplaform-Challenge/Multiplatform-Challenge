import SwiftUI

public struct TextFieldModalView: View {
    let title: String
    let placeholder: String
    let titleFont: Font
    let foregrounColor: Color
    
    @Binding var nameText: String
    
    public init(nameText: Binding<String>,
                title: String,
                placeholder: String,
                titleFont: Font = Font.headline,
                foregrounColor: Color = Color.primary) {
        _nameText = nameText
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
            TextField(placeholder, text: $nameText)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .multilineTextAlignment(.trailing)
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
