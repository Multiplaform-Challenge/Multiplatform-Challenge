import Foundation
import CoreData

class CoreDataManager {

    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func getItemById(id: NSManagedObjectID) -> Item? {
        do {
            return try viewContext.existingObject(with: id) as? Item
        } catch {
            return nil
        }
    }

    func deleteItem(item: Item) {
        viewContext.delete(item)
        save()
    }

    func getAllItens() -> [Item] {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }

    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }

    func getMonayInfo() -> [ShoppingList] {
        let request: NSFetchRequest = ShoppingList.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }

    private init() {
        persistentContainer = NSPersistentContainer(name: "MultiplatformChallenge")
        persistentContainer.loadPersistentStores { (_ , error) in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack \(error)")
            }
        }
    }
}
