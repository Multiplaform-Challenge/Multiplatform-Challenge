import SwiftUI
struct FontNameManager {
    struct Poppins {
        static let regular          = "Poppins-Regular"
        static let italic           = "Poppins-Italic"
        static let thin             = "Poppins-Thin"
        static let thinItalic       = "Poppins-ThinItalic"
        static let extraLight       = "Poppins-ExtraLight"
        static let extraLightItalic = "Poppins-ExtraLightItalic"
        static let light            = "Poppins-Light"
        static let medium           = "Poppins-Medium"
        static let mediumItalic     = "Poppins-MediumItalic"
        static let semiBold         = "Poppins-SemiBold"
        static let semiBoldItalic   = "Poppins-SemiBoldItalic"
        static let bold             = "Poppins-Bold"
        static let boldItalic       = "Poppins-BoldItalic"
        static let extraBold        = "Poppins-ExtraBold"
        static let extraBoldItalic  = "Poppins-ExtraBoldItalic"
        static let black            = "Poppins-Black"
        static let blackItalic      = "Poppins-BlackItalic"
    }
    struct CustomFont {
        static let headerTitleComponentFont = Font.custom(FontNameManager.Poppins.semiBold, size: 17)
        static let headerLargeTitleComponentFont = Font.custom(FontNameManager.Poppins.bold, size: 32)
        static let titleComponentFont = Font.custom(FontNameManager.Poppins.medium, size: 20)
        static let textfieldComponentFont = Font.custom(FontNameManager.Poppins.regular, size: 20)
        static let boxQuantityComponentFont = Font.custom(FontNameManager.Poppins.medium, size: 27)
        static let textAreaComponentFont = Font.custom(FontNameManager.Poppins.regular, size: 24)
    }
}
