//
//  MovieExplorer
//

import Foundation
import ImageLoader
import TheMovieDBClient

// MARK: - App single instance dependencies

class DIContainer {
    lazy var imageLoader = ImageLoader(
        cache: InMemoryImageCache())
}

// MARK: - App multi instances dependencies

extension DIContainer {
    var movieRepository: MovieRepository {
        MovieRepository(movieDBClient: movieDBClient)
    }
}

// MARK: - Private Helpers

private extension DIContainer {
    var movieDBClient: TheMovieDBClient {
        TheMovieDBClient()
    }
}
