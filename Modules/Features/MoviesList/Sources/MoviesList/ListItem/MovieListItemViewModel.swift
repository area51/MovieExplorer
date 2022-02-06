//
//  PopularMovies
//

import SwiftUI
import Domain

public final class MovieListItemViewModel: ObservableObject {

    public struct Dependencies {
        public let movie: Movie
        public var loadImageFromPath: (String) async throws -> UIImage?

        public init(
            movie: Movie,
            loadImageFromPath: @escaping (String) async throws -> UIImage?) {

                self.movie = movie
                self.loadImageFromPath = loadImageFromPath
            }
    }

    private let dependencies: Dependencies

    public init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    public var movie: Movie {
        self.dependencies.movie
    }

    public var loadImageFromPath: (String) async throws -> UIImage? {
        dependencies.loadImageFromPath
    }
}
