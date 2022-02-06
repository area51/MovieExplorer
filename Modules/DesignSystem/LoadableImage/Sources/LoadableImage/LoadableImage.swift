//
//  LoadableImage
//

import SwiftUI

public struct LoadableImage: View {
    public struct Dependencies {
        public var imagePath: String?
        public var loadImageFromPath: (String?) async throws -> UIImage?

        public init(
            imagePath: String?,
            loadImageFromPath: @escaping (String?) async throws -> UIImage?) {

                self.imagePath = imagePath
                self.loadImageFromPath = loadImageFromPath
            }
    }

    @State private var image: UIImage?
    @State private var failedToLoad: Bool = false

    public let dependencies: Dependencies

    public init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    public var body: some View {
        ZStack {
            if let image = self.image {
                Image(uiImage: image)
                    .resizable()
            } else if failedToLoad {
                Rectangle()
                    .fill(Color.purple.opacity(0.1))
                // TODO: Check why rectangle is not getting correct frame size unless specified here
            } else {
                ProgressView()
            }
        }.task {
            let path = dependencies.imagePath
            image = try? await dependencies.loadImageFromPath(path)
            failedToLoad = image == nil
        }
    }
}

// MARK: - Preview

#if DEBUG

struct LoadableImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoadableImage(.init(
                imagePath: "backdrop-matrix",
                loadImageFromPath: { UIImage(named: $0!) }))
        }
    }
}
#endif
