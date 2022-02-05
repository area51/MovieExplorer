//
//  MovieExplorer
//

import Foundation
import Domain
import TheMovieDBClient

extension DiscoverResult {
    func toMovie() -> Movie {
        .init(
            id: self.id,
            title: self.title,
            overview: self.overview,
            releaseDate: self.releaseDate,
            posterPath: self.posterPath,
            backdropPath: self.backdropPath,
            voteAverage: self.voteAverage)
    }
}
