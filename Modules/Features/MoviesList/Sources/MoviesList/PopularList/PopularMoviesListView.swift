//
//  PopularMovies
//

import SwiftUI

public struct PopularMoviesListView: View {
    @ObservedObject private(set) var viewModel: PopularMoviesViewModel

    public init(viewModel: PopularMoviesViewModel) {
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

struct PopularMoviesListView_Previews: PreviewProvider {
    static let repository = FakeMoviesRepository()

    static let viewModel: PopularMoviesViewModel = {
        typealias Dependencies = PopularMoviesViewModel.Dependencies

        var itemViewModel: (Movie) -> MovieDetailViewModel = { movie in
            MovieDetailViewModel(.init(
                movie: movie,
                loadImageFromPath: { UIImage(named: $0) }))
        }

        let dependencies = Dependencies(
            movies: repository.movies,
            updateMovies: {},
            itemViewModel: itemViewModel
        )
        return PopularMoviesViewModel(dependencies)
    }()

    static var previews: some View {
        Group {
            PopularMoviesListView(viewModel: viewModel)
        }
    }
}

class FakeMoviesRepository  {
    var isLoading: CurrentValueSubject<Bool, Never> = .init(false)
    var movies : CurrentValueSubject<[Movie], Error> = .init([
        Movie.alien,
        Movie.fightclub,
        Movie.matrix,
        Movie.truman
    ])
}

#endif
