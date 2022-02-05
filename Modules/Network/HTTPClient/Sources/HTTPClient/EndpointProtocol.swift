//
//  NetworkLayer
//

import Foundation

public protocol EndpointProtocol {
    // HTTP or HTTPS
    var scheme: EndpointScheme { get }

    // Example: "api.flickr.com"
    var baseURL: String { get }

    // Example: "/services/rest/"
    var path: String { get }

    // Example: [URLQueryItem(name: "api_key", value: API_KEY)]
    var parameters: [URLQueryItem] { get }

    // Example: GET, POST, PUT, DELETE
    var method: EndpointMethod { get }

    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy { get }
}

extension EndpointProtocol {
    var scheme: EndpointScheme { .HTTPS }
    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy { .useDefaultKeys }
}

public enum EndpointScheme: String {
    case HTTP
    case HTTPS
}

public enum EndpointMethod: String {
    case GET
    case HEAD
    case POST
    case PUT
    case DELETE
    case CONNECT
    case OPTIONS
    case TRACE
    case PATCH
}
