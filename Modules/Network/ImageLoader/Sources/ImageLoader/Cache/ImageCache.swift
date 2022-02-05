//
// ImageLoader
//

import UIKit

public protocol ImageCache: AnyObject {
    // Return the image associated with the given url
    func image(for url: URL) -> UIImage?

    // Insert the image of the specified url in the cache
    func insertImage(_ image: UIImage?, for url: URL)

    // Remove all images from the cache
    func removeAllImages()

    // Remove the image of the specified url in the cache
    func removeImage(for url: URL)

    // Access the value associated with the given url for reading and writing
    subscript(_ url: URL) -> UIImage? { get set }
}
