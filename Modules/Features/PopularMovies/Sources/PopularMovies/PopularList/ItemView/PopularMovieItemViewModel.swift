//
//  PopularMovies
//

import SwiftUI
import Combine
import Domain

@MainActor public final class PopularMovieItemViewModel: ObservableObject {
    let movie: Movie
    @Published private(set) var poster: UIImage?

    public struct Dependencies {
        var loadImage: (URL) async throws -> UIImage?
    }

    private let dependencies: Dependencies

    public init(dependencies: Dependencies, movie: Movie) {
        self.dependencies = dependencies
        self.movie = movie
    }

    public func loadImage(url: URL) {
        Task {
            self.poster = try? await dependencies.loadImage(url)
        }
    }
}
