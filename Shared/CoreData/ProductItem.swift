import CoreData

struct ProductItem {

    let item: Item

    var id: NSManagedObjectID {
        return item.objectID
    }

    var name: String {
        return item.name ?? ""
    }

    var price: Float {
        return item.price
    }

    var quantity: Int16 {
        return item.quantity
    }

    var isChecked: Bool {
        return item.isChecked
    }

}
