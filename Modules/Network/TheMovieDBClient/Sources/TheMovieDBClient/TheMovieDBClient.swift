//
//  TheMovieDBApiClient
//

import Foundation
import HTTPClient

public class TheMovieDBClient {
    lazy var httpClient = HTTPClient()

    public init() {}

    public func getPopularMovies() async throws -> DiscoverResponseDTO {
        let endpoint = DiscoverMovieEndpoint()
        return try await httpClient.request(endpoint)
    }
}

public struct DiscoverResponseDTO: Decodable {
    public let page: Int
    public let results: [DiscoverResult]
    public let totalResults: Int
    public let totalPages: Int
}

public struct DiscoverResult: Decodable {
    public let id: Int
    public let title: String
    public let overview: String
    public let releaseDate: String
    public let posterPath: String?
    public let backdropPath: String?
    public let voteAverage: Float
}
