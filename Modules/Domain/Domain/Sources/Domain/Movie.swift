//
//  MovieExplorer
//

import Foundation

public struct Movie {
    public let id: Int
    public let title: String
    public let overview: String
    public let releaseDate: String
    public let posterPath: String?
    public let backdropPath: String?
    public let voteAverage: Float

    public init(
        id: Int,
        title: String,
        overview: String,
        releaseDate: String,
        posterPath: String?,
        backdropPath: String?,
        voteAverage: Float) {

            self.id = id
            self.title = title
            self.overview = overview
            self.releaseDate = releaseDate
            self.posterPath = posterPath
            self.backdropPath = backdropPath
            self.voteAverage = voteAverage
    }
}

extension Movie: Identifiable {}
