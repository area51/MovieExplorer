//
// ImageLoader
//

import UIKit
import Combine

public final class InMemoryImageCache {

    // 1st level cache, contains encoded images
    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = config.countLimit
        return cache
    }()

    // 2nd level cache, contains decoded images
    private lazy var decodedImageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.totalCostLimit = config.memoryLimit
        return cache
    }()

    private let lock = NSLock()
    private let config: Config

    public struct Config {
        public let countLimit: Int
        public let memoryLimit: Int

        public static let defaultConfig = Config(
            countLimit: 100,
            memoryLimit: 100 * 1024 * 1024)
    }

    public init(config: Config = Config.defaultConfig) {
        self.config = config
    }
}

extension InMemoryImageCache: ImageCache {

    public func image(for url: URL) -> UIImage? {

        lock.lock(); defer { lock.unlock() }

        let decodedImage = decodedImageCache
            .object(forKey: url as AnyObject) as? UIImage

        if decodedImage != nil { return decodedImage }

        let image = imageCache.object(
            forKey: url as AnyObject) as? UIImage

        guard let decodedImage = image?.decodedImage() else {
            return nil
        }

        decodedImageCache.setObject(
            image as AnyObject,
            forKey: url as AnyObject,
            cost: decodedImage.diskSize)

        return decodedImage
    }

    public func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else {
            return removeImage(for: url)
        }

        let decodedImage = image.decodedImage()

        lock.lock(); defer { lock.unlock() }

        imageCache.setObject(
            decodedImage,
            forKey: url as AnyObject)

        decodedImageCache.setObject(
            image as AnyObject,
            forKey: url as AnyObject,
            cost: decodedImage.diskSize)
    }

    public func removeImage(for url: URL) {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeObject(forKey: url as AnyObject)
        decodedImageCache.removeObject(forKey: url as AnyObject)
    }

    public func removeAllImages() {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeAllObjects()
        decodedImageCache.removeAllObjects()
    }

    public subscript(_ key: URL) -> UIImage? {
        get { image(for: key) }
        set { insertImage(newValue, for: key) }
    }
}
