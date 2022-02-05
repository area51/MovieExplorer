//
//  MovieExplorer
//

import Foundation
import Combine
import Domain
import TheMovieDBClient

class MovieRepository {
    private let movieDBClient: TheMovieDBClient
    private var cancellable: AnyCancellable?
    private(set) var movies : CurrentValueSubject<[Movie], Error> = .init([])
    private(set) var isLoading: CurrentValueSubject<Bool, Never> = .init(false)

    init(movieDBClient: TheMovieDBClient) {
        self.movieDBClient = movieDBClient
        updatePopularMovies()
    }

    func updatePopularMovies() {
        isLoading.send(true)
        Task {
            do {
                let response: DiscoverResponseDTO =
                    try await movieDBClient.getPopularMovies()
                let movies = response.results.map { $0.toMovie() }
                self.movies.send(movies)
            } catch (let error) {
                self.movies.send(completion: .failure(error))
            }
        }
        isLoading.send(false)
    }
}
