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

        let viewModel = PopularMoviesViewModel(dependencies)
        return PopularMoviesListView(viewModel: viewModel)
    }

    private func itemViewModel(for movie: Movie) -> MovieDetailViewModel {

        let dependencies = MovieDetailViewModel.Dependencies(
            movie: movie,
            loadImageFromPath: { [weak diContainer] path in
                try? await diContainer?.imageLoader.loadImageFromPath(path)
            })

        return MovieDetailViewModel(dependencies)
    }
}
