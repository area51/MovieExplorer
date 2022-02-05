//
//  MovieExplorer
//

#if DEBUG
import Foundation
import Domain

extension Movie {
    public static func fake(
        id: Int,
        title: String = "Title",
        overview: String = "Overview",
        releaseDate: String = "01/01/2023",
        posterPath: String? = nil,
        backdropPath: String? = nil,
        voteAverage: Float = 1.8) -> Movie {

            Movie(
                id: id,
                title: title,
                overview: overview,
                releaseDate: releaseDate,
                posterPath: posterPath,
                backdropPath: backdropPath,
                voteAverage: voteAverage)
        }

    public static var matrix: Movie {
        fake(id: 1000, title: "The Matrix", posterPath: "matrix.com")
    }
}
#endif
