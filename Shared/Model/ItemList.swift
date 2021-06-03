import Foundation

struct ItemList {

    var name: String
    var price: Float
    var quantity: Int16
    var isChecked: Bool

    init() {
        name = ""
        price = 0.00
        quantity = 0
        isChecked = false
    }
}
