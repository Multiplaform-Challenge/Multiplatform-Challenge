import Foundation
import CoreData

class ShoppingListViewModel: ObservableObject {

    var name: String = ""
    var quantity: Int16 = 0
    var price: Float = 1.00
    var isChecked: Bool = false

    @Published var itens: [ProductItem] = []

    func getAllItens() {
        itens = CoreDataManager.shared.getAllItens().map(ProductItem.init)
    }

    func delete(_ item: ProductItem) {
        let existingItem = CoreDataManager.shared.getItemById(id: item.id)
        if let existingItem = existingItem {
            CoreDataManager.shared.deleteItem(item: existingItem)
        }
    }

    func save() {
        let item = Item(context: CoreDataManager.shared.viewContext)
        item.name = name
        item.price = price
        item.isChecked = isChecked
        item.quantity = quantity
        CoreDataManager.shared.save()
    }

    func upDate(id: NSManagedObjectID) {
        CoreDataManager.shared.updateItem(itemId: id,
                                          name: name,
                                          price: price,
                                          quantity: quantity,
                                          isChecked: isChecked)
    }

}
