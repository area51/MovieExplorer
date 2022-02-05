//
//  MovieExplorer
//

import Foundation
import PopularMovies

class PopularMoviesListViewComposer {
    static func compose(diContainer: DIContainer) -> PopularMoviesListView {
        typealias Dependencies = PopularMoviesViewModel.Dependencies
        let dependencies = Dependencies(
            movies: diContainer.movieRepository.movies,
            updateMovies: diContainer.movieRepository.updatePopularMovies,
            loadImage: diContainer.imageLoader.loadImage(from:))
        let viewModel = PopularMoviesViewModel(dependencies: dependencies)
        return PopularMoviesListView(viewModel: viewModel)
    }
}
