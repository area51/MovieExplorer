//
//  MovieExplorer
//

import Foundation
import Domain
import MoviesList

class PopularMoviesListViewComposer {
    let diContainer: DIContainer

    init(_ diContainer: DIContainer) {
        self.diContainer = diContainer
    }

    func compose() -> MoviesListView {
        typealias Dependencies = MoviesListViewModel.Dependencies

        let di = diContainer

        let dependencies = Dependencies(
            movies: di.movieRepository.movies,
            updateMovies: di.movieRepository.updatePopularMovies,
            itemViewModel: itemViewModel(for:))

        let viewModel = MoviesListViewModel(dependencies)
        return MoviesListView(viewModel: viewModel)
    }

    private func itemViewModel(for movie: Movie) -> MovieListItemViewModel {

        let dependencies = MovieListItemViewModel.Dependencies(
            movie: movie,
            loadImageFromPath: { [weak diContainer] path in
                try? await diContainer?.imageLoader.loadImageFromPath(path)
            })

        return MovieListItemViewModel(dependencies)
    }
}
