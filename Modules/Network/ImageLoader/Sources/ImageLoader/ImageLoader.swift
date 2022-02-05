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

    public func loadImage(from url: URL) async throws -> UIImage? {
        if let image = cache[url] {
            return image
        }
        let (data, _) = try await session.data(from: url)
        guard let image: UIImage = UIImage(data: data) else { return nil }
        self.cache[url] = image
        return image
    }
}
