//
//  PopularMovies
//

import Foundation
import Combine
import Domain
import UIKit

public class MoviesListViewModel: ObservableObject {

    public struct Dependencies {
        public var movies : CurrentValueSubject<[Movie], Error>
        public var updateMovies: () async throws -> Void
        public var itemViewModel: (Movie) -> MovieDetailViewModel

        public init(
            movies: CurrentValueSubject<[Movie], Error>,
            updateMovies: @escaping () async throws -> Void,
            itemViewModel: @escaping (Movie) -> MovieDetailViewModel) {

                self.movies = movies
                self.updateMovies = updateMovies
                self.itemViewModel = itemViewModel
            }
    }

    private let dependencies: Dependencies
    private var cancellable: AnyCancellable?

    @Published private(set) var movies: [Movie] = []
    @Published private(set) var isLoading: Bool = false

    public var itemViewModel: (Movie) -> MovieDetailViewModel {
        dependencies.itemViewModel
    }

    public init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    @MainActor func onAppear() {
        cancellable = dependencies
            .movies
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { error in
                // TODO: handle error
                debugPrint(error)
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
