//
//  MovieExplorer
//

import Foundation
import Domain
import TheMovieDBClient

extension DiscoverResult {
    func toMovie() -> Movie {

        let posterFullPath: String? = {
            guard let path = self.posterPath else { return nil }
            return URL.movieDBImage(path: path, type: .w500)?.absoluteString
        }()

        let backdropFullPath: String? = {
            guard let path = self.backdropPath else { return nil }
            return URL.movieDBImage(path: path, type: .original)?.absoluteString
        }()

        return .init(
            id: self.id,
            title: self.title,
            overview: self.overview,
            releaseDate: self.releaseDate,
            posterPath: posterFullPath,
            backdropPath: backdropFullPath,
            voteAverage: self.voteAverage)
    }
}

// MARK: - Adapter Helpers

private extension URL {
    enum MovieDBImageType: String {
        case w500 = "/w500"
        case original = "/original"
    }

    static func movieDBImage(
        path: String,
        type: MovieDBImageType) -> URL? {

            let baseURL = "https://image.tmdb.org/t/p"
            return URL(string: baseURL + type.rawValue + path)
        }
}
