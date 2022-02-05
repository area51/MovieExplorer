//
//  MovieExplorer
//

import Foundation
import Domain
import PopularMovies

class PopularMoviesListViewComposer {
    let diContainer: DIContainer

    init(_ diContainer: DIContainer) {
        self.diContainer = diContainer
    }

    func compose() -> PopularMoviesListView {
        typealias Dependencies = PopularMoviesViewModel.Dependencies

        let di = diContainer

        let dependencies = Dependencies(
            movies: di.movieRepository.movies,
            updateMovies: di.movieRepository.updatePopularMovies,
            itemViewModel: itemViewModel(for:))

        let viewModel = PopularMoviesViewModel(dependencies: dependencies)
        return PopularMoviesListView(viewModel: viewModel)
    }

    private func itemViewModel(for movie: Movie) -> PopularMovieItemViewModel {

        let dependencies = PopularMovieItemViewModel.Dependencies(
            movie: movie,
            loadImage: { [weak diContainer] url in
                try? await diContainer?.imageLoader.loadImage(from: url)
            })

        return PopularMovieItemViewModel(dependencies: dependencies)
    }
}
