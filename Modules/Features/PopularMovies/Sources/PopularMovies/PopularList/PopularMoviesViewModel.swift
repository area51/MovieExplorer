//
//  PopularMovies
//

import Foundation
import Combine
import Domain
import UIKit

public class PopularMoviesViewModel: ObservableObject {
    private var cancellable: AnyCancellable?

    @Published private(set) var movies: [Movie] = []
    @Published private(set) var isLoading: Bool = false

    public struct Dependencies {
        public var movies : CurrentValueSubject<[Movie], Error>
        public var updateMovies: () async throws -> Void
        public var loadImage: (URL) async throws -> UIImage?

        public init(
            movies: CurrentValueSubject<[Movie], Error>,
            updateMovies: @escaping () async throws -> Void,
            loadImage: @escaping (URL) async throws -> UIImage?) {

                self.movies = movies
                self.updateMovies = updateMovies
                self.loadImage = loadImage
        }
    }

    private let dependencies: Dependencies

    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    @MainActor func onAppear() {
        cancellable = dependencies
            .movies
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { error in
                // TODO: handle error
                print(error)
            }, receiveValue: { [weak self] movies in
                self?.movies = movies
            })

        updateMovies()
    }

    private func updateMovies() {
        isLoading = true
        Task {
            do {
                try await dependencies.updateMovies()
            } catch (let error) {
                print(error)
                // TODO: handle error
            }
        }
        isLoading = false
    }

    func onDisappear() {
        cancellable?.cancel()
    }
}
