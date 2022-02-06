//
//  LocalPersistence
//

import Foundation
import CoreData
import Domain

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

    public init(descriptions: [NSPersistentStoreDescription]? = nil) {
        if let descriptions = descriptions {
            container.persistentStoreDescriptions = descriptions
        }
        container.loadPersistentStores { _, error in
            if let error = error {
                debugPrint("😵 Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }

    public func fetchAllMovies() throws -> [Movie] {
        let entityName = String(describing: MovieDAO.self)
        let fetchRequest = NSFetchRequest<MovieDAO>(entityName: entityName)
        fetchRequest.resultType = .managedObjectResultType
        let daos: [MovieDAO] = try context.fetch(fetchRequest)
        return daos.compactMap { try? DAOMovieAdapter.movie(from: $0) }
    }

    public func persist(_ movies: [Movie]) throws {
        print("persist called....")
        try movies.forEach { movie in
            print("saving... \(movie.title)")
            _ = try DAOMovieAdapter.dao(from: movie, in: context)
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
