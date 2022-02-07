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
    private var cancellables: [AnyCancellable] = []

    @Published private(set) var movies: [Movie] = []
    @Published private(set) var isLoading: Bool = false

    public var itemViewModel: (Movie) -> MovieListItemViewModel {
        dependencies.itemViewModel
    }

    public init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
        dependencies
            .movies
            .receive(on: RunLoop.main)
            .assign(to: \.movies, on: self)
            .store(in: &cancellables)
    }

    @MainActor func onAppear() {
        updateMovies()
    }

    private func updateMovies() {
        Task {
            do {
                try await dependencies.updateMovies()
            } catch (let error) {
                debugPrint(error)
            }
        }
    }

    func onDisappear() {
        cancellables.forEach { $0.cancel() }
    }
}
