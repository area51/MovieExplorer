//
//  PopularMovies
//

import Foundation
import Combine
import Domain
import UIKit

public class MoviesListViewModel: ObservableObject {

    public struct Dependencies {
        public var movies : CurrentValueSubject<[Movie], Never>
        public var updateMovies: () async throws -> Void
        public var itemViewModel: (Movie) -> MovieListItemViewModel

        public init(
            movies: CurrentValueSubject<[Movie], Never>,
            updateMovies: @escaping () async throws -> Void,
            itemViewModel: @escaping (Movie) -> MovieListItemViewModel) {

                self.movies = movies
                self.updateMovies = updateMovies
                self.itemViewModel = itemViewModel
            }
    }

    private let dependencies: Dependencies
    private var cancellable: AnyCancellable?

    @Published private(set) var movies: [Movie] = [Movie.matrix]
    @Published private(set) var isLoading: Bool = false

    public var itemViewModel: (Movie) -> MovieListItemViewModel {
        dependencies.itemViewModel
    }

    public init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    @MainActor func onAppear() {
        cancellable = dependencies
            .movies
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] movies in
                self?.movies = movies
                debugPrint("received movies: \(movies.count)")
            })
        // TODO: handle error

        updateMovies()
    }

    private func updateMovies() {
        isLoading = true
        Task {
            do {
                try await dependencies.updateMovies()
            } catch (let error) {
                debugPrint(error)
                // TODO: handle error
            }
        }
        isLoading = false
    }

    func onDisappear() {
        cancellable?.cancel()
    }
}
