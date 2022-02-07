//
//  MovieExplorer
//

import Foundation
import Combine
import Domain
import TheMovieDBClient
import LocalPersistence

class MovieRepository {
    private let movieDBClient: TheMovieDBClient
    private let persistencyController: LocalPersistenceController

    private(set) var movies : CurrentValueSubject<[Movie], Never> = .init([])
    private(set) var isLoading: CurrentValueSubject<Bool, Never> = .init(false)
    private(set) var loadingError: CurrentValueSubject<Error?, Never> = .init(nil)

    private var cancellable: AnyCancellable?

    init(
        movieDBClient: TheMovieDBClient,
        persistenceController: LocalPersistenceController
    ) {

        self.movieDBClient = movieDBClient
        self.persistencyController = persistenceController
    }

    func updatePopularMovies() {
        guard isLoading.value == false else { return }
        Task {
            do {
                let movies = try await fetchPopularMoviesFromNetwork()
                debugPrint("Recovered \(movies.count) movies from network")
                self.movies.send(movies)
            } catch (let error) {
                self.loadingError.send(error)
            }
        }
    }

    private func fetchPopularMoviesFromCache() -> [Movie] {
        let cached = try? persistencyController.fetchAllMovies()
        return cached ?? []
    }

    private func fetchPopularMoviesFromNetwork() async throws -> [Movie] {
        defer { isLoading.send(false) }
        isLoading.send(true)

        return try await movieDBClient
            .getPopularMovies()
            .results
            .map { $0.toMovie() }
    }

    private func cacheMovies(_ movies: [Movie]) throws {
        try persistencyController.persist(movies)
        persistencyController.saveContext()
    }
}
