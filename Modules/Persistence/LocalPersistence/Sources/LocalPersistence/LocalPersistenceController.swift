//
//  LocalPersistence
//

import Foundation
import CoreData

public class LocalPersistenceController {
    let container: NSPersistentContainer = {
        guard let modelURL = Bundle.module.url(
            forResource:"LocalPersistence",
            withExtension: "momd") else {
                fatalError("😵 Data model not found")
            }

        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("😵 Failed to create NSManagedObjectModel from data model")
        }

        return NSPersistentContainer(
            name: "LocalPersistence",
            managedObjectModel: model)
    }()

    public var context: NSManagedObjectContext {
        container.viewContext
    }

    public init(descriptions: [NSPersistentStoreDescription] = []) {
        container.persistentStoreDescriptions = descriptions
        container.loadPersistentStores { _, error in
            if let error = error {
                debugPrint("😵 Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }

    public func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("😵 Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
