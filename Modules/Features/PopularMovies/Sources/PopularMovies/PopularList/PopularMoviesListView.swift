//
//  PopularMovies
//

import SwiftUI
import ImageLoader

public struct PopularMoviesListView: View {
    @ObservedObject private(set) var viewModel: PopularMoviesViewModel

    public init(viewModel: PopularMoviesViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.movies) { movie in
                        NavigationLink {
                            MovieDetailView()
                        } label: {
                            let viewModel = PopularMovieItemViewModel(
                                dependencies: .init(loadImage: { url in
                                    let cache = InMemoryImageCache()
                                    let imageLoader = ImageLoader(cache: cache)
                                    return try? await imageLoader.loadImage(from: url)
                                }),
                                movie: movie)
                            PopularMovieItemView(viewModel: viewModel)
                        }

                    }
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
    // TODO: Use a fake image loader
    static let imageLoader = ImageLoader(cache: InMemoryImageCache())

    static let viewModel: PopularMoviesViewModel = {
        typealias Dependencies = PopularMoviesViewModel.Dependencies

        let dependencies = Dependencies(
            movies: repository.movies,
            updateMovies: {},
            loadImage: imageLoader.loadImage(from:)
        )
        return PopularMoviesViewModel(dependencies: dependencies)
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
        Movie.fake(id: 1, title: "Alien (1979)"),
        Movie.fake(id: 2, title: "Fight Club"),
        Movie.fake(id: 3, title: "The Matrix"),
        Movie.fake(id: 4, title: "The Truman Show")
    ])
}

#endif
