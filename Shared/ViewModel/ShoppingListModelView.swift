import Foundation
import CoreData

class ShoppingListViewModel: ObservableObject {
    var budget: Double = 250.00
    var objective: String = "Compras da semana"

    @Published var itens: [ProductItem] = []
    @Published var list: [ListDetails] = []

    func getAllItens() {
        itens = CoreDataManager.shared.getAllItens().map(ProductItem.init)
        getMonayDetails()
        if list.isEmpty {
            list.append(saveMoneyInfo())
        } else {
            budget = list.first!.budget
            objective = list.first!.objective
        }
    }

    func delete(_ item: ProductItem) {
        let existingItem = CoreDataManager.shared.getItemById(id: item.id)
        if let existingItem = existingItem {
            CoreDataManager.shared.deleteItem(item: existingItem)
        }
    }

    func save(newItem: ItemList) {
        let item = Item(context: CoreDataManager.shared.viewContext)
        item.name = newItem.name
        item.price = newItem.price
        item.isChecked = newItem.isChecked
        item.quantity = newItem.quantity
        CoreDataManager.shared.save()
    }

    func update(updatedList: ItemList, id: NSManagedObjectID) {
        CoreDataManager.shared.updateItem(itemId: id,
                                          name: updatedList.name,
                                          price: updatedList.price,
                                          quantity: updatedList.quantity,
                                          isChecked: updatedList.isChecked)
    }

    func saveMoneyInfo() -> ListDetails {
        let list = ShoppingList(context: CoreDataManager.shared.viewContext)
        list.budget = budget
        list.objective = objective
        CoreDataManager.shared.save()
        return ListDetails.init(shoppingList: list)
    }

    func getMonayDetails() {
        list = CoreDataManager.shared.getMonayInfo().map(ListDetails.init)
    }

    func updateMoneyDatails(_ list: ListDetails, newList: (budget: Double, objective: String)) {
        let existingList = CoreDataManager.shared.getMonayInfo().first
        if let existingList = existingList {
            existingList.setValue(newList.budget, forKey: "budget")
            existingList.setValue(newList.objective, forKey: "objective")
            CoreDataManager.shared.save()
        }
    }

}
