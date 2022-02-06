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

            .init(
                id: id,
                title: title,
                overview: overview,
                releaseDate: releaseDate,
                posterPath: posterPath,
                backdropPath: backdropPath,
                voteAverage: voteAverage)
        }

    public static var matrix: Movie {
        fake(
            id: 1000,
            title: "The Matrix",
            posterPath: "matrix",
            backdropPath: "backdrop-matrix")
    }

    public static var alien: Movie {
        fake(
            id: 1001,
            title: "Alien (1979)",
            posterPath: "alien",
            backdropPath: "backdrop-alien")
    }

    public static var fightclub: Movie {
        fake(
            id: 1002,
            title: "Fight Club",
            posterPath: "fightclub",
            backdropPath: "backdrop-fightclub")
    }

    public static var truman: Movie {
        fake(
            id: 1003,
            title: "The Truman Show",
            posterPath: "truman",
            backdropPath: "backdrop-truman")
    }
}
#endif
