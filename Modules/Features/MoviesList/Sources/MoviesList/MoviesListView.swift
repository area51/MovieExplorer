//
//  PopularMovies
//

import SwiftUI

public struct MoviesListView: View {
    @ObservedObject private(set) var viewModel: MoviesListViewModel

    public init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.movies) { movie in
                        NavigationLink {
                            MovieDetailView(
                                viewModel: viewModel.itemViewModel(movie))
                        } label: {
                            MovieListItemView(
                                viewModel: viewModel.itemViewModel(movie))
                        }
                    }
                    Spacer()
                }
                .padding()
            }
            .listStyle(.plain)
            .buttonStyle(.plain)
            .navigationTitle("Popular Movies")
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(.stack)
        .onAppear(perform: { viewModel.onAppear() })
        .onDisappear(perform: { viewModel.onDisappear() })
    }
}

// MARK: - Preview

#if DEBUG
import Domain
import Combine
import PreviewUtils

struct PopularMoviesListView_Previews: PreviewProvider {
    static let repository = FakeMoviesRepository()

    static let viewModel: MoviesListViewModel = {
        typealias Dependencies = MoviesListViewModel.Dependencies

        var itemViewModel: (Movie) -> MovieListItemViewModel = { movie in
            MovieListItemViewModel(.init(
                movie: movie,
                loadImageFromPath: { UIImage(named: $0) }))
        }

        let dependencies = Dependencies(
            movies: repository.movies,
            updateMovies: {},
            itemViewModel: itemViewModel
        )
        return MoviesListViewModel(dependencies)
    }()

    static var previews: some View {
        Group {
            MoviesListView(viewModel: viewModel)
        }
    }
}
#endif
