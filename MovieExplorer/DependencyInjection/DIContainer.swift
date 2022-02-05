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

    lazy var movieRepository =
        MovieRepository(movieDBClient: movieDBClient)
}

// MARK: - App multi instances dependencies

extension DIContainer {
}

// MARK: - Private Helpers

private extension DIContainer {
    var movieDBClient: TheMovieDBClient {
        TheMovieDBClient()
    }
}
