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

/*
 Technically this is not the best place for this extension.
 The alternative would be to have this extension on the Feature that needs it.
 But that means duplicating this code in every feature of the project.
*/
extension Movie: Identifiable {}
