//
//  ImageLoader
//

import UIKit

public final class ImageLoader {

    private let cache: ImageCache
    private lazy var session = URLSession.shared
    
    private lazy var backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()

    public init(cache: ImageCache) {
        self.cache = cache
    }

    public func loadImageFromPath(_ path: String) async throws -> UIImage? {
        guard let url = URL(string: path) else { return nil }
        if let image = cache[url] {
            debugPrint("🦸 [cached]: \(url.absoluteString)")
            return image
        }
        let (data, response) = try await session.data(from: url)
        if let message = response.logMessage { debugPrint(message) }
        guard let image: UIImage = UIImage(data: data) else { return nil }
        self.cache[url] = image
        return image
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
            return "🧑‍🎨"
        }
        return "💣"
    }
}
