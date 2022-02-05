//
// NetworkLayer
//

import Foundation

public final class HTTPClient {
    private lazy var session = URLSession(configuration: .default)

    public init() {}

    public func request<T:Decodable>(_ endpoint: EndpointProtocol) async throws -> T {
        let request = try endpoint.urlRequest()
        let (data, response) = try await session.data(for: request)
        if let message = response.logMessage { debugPrint(message) }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}

extension URLResponse {
    var logMessage: String? {
        guard let response = self as? HTTPURLResponse else { return nil }
        guard let icon = self.icon,
              let url = response.url?.absoluteString else { return nil }
        return "\(icon) [\(response.statusCode)]: \(url)"
    }

    var icon: String? {
        guard let response = self as? HTTPURLResponse else { return nil }
        let successRange = 200...299
        if successRange.contains(response.statusCode) {
            return "💌"
        }
        return "💣"
    }
}

public enum HTTPClientError: String, Error {
    case malformedURL
}

extension EndpointProtocol {
    func urlRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = baseURL
        components.path = path
        components.queryItems = parameters

        guard let url = components.url else {
            throw HTTPClientError.malformedURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
