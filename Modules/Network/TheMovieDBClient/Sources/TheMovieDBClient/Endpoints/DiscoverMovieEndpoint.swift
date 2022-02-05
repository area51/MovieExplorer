//
// TheMovieDBApiClient
//

import Foundation
import HTTPClient

struct DiscoverMovieEndpoint: TheMobieDBEndpoint {
    var path: String {
        "/3/discover/movie"
    }
    
    var method: EndpointMethod { .GET }

    var parameters: [URLQueryItem] {
        [
            URLQueryItem(name: "api_key", value: "618b9359f7aaea1ebb787a48852c0689"),
            URLQueryItem(name: "certification_country", value: "US"),
            URLQueryItem(name: "certification", value: "R"),
            URLQueryItem(name: "sort_by", value: "vote_average.desc")
        ]
    }
}
