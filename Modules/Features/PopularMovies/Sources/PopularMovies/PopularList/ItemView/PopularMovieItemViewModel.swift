//
//  PopularMovies
//

import SwiftUI
import Combine 
import Domain

public final class PopularMovieItemViewModel: ObservableObject {

    public struct Dependencies {
        public let movie: Movie
        public var loadImage: (URL) async throws -> UIImage?

        public init(
            movie: Movie,
            loadImage: @escaping (URL) async throws -> UIImage?) {

                self.movie = movie
                self.loadImage = loadImage
            }
    }

    public var movie: Movie {
        self.dependencies.movie
    }

    private let dependencies: Dependencies
    @Published private(set) var poster: UIImage?

    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    @MainActor public func loadImage(url: URL) {
        Task {
            self.poster = try? await dependencies.loadImage(url)
        }
    }
}
