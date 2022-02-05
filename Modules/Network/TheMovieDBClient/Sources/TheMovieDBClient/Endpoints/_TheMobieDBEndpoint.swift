//
// TheMovieDBApiClient
//

import Foundation
import HTTPClient

protocol TheMobieDBEndpoint: EndpointProtocol {}

extension TheMobieDBEndpoint {
    var scheme: EndpointScheme { .HTTPS }

    var baseURL: String {
        "api.themoviedb.org"
    }

    var parameters: [URLQueryItem] { [] }

    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy {
        .convertFromSnakeCase
    }
}
