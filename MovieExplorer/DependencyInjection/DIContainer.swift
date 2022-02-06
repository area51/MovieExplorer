//
//  MovieExplorer
//

import Foundation
import ImageLoader
import TheMovieDBClient
import LocalPersistence

// MARK: - App single instance dependencies

class DIContainer {
    lazy var imageLoader = ImageLoader(
        cache: InMemoryImageCache())

    lazy var movieRepository = MovieRepository(
        movieDBClient: movieDBClient,
        persistenceController: persistenceController)

    lazy var persistenceController = LocalPersistenceController()

    deinit {
        persistenceController.saveContext()
    }
}

// MARK: - Private Helpers

private extension DIContainer {
    var movieDBClient: TheMovieDBClient {
        TheMovieDBClient()
    }
}
