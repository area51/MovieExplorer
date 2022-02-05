//
//  PopularMovies
//

import SwiftUI

public struct PopularMovieItemView: View {

    @ObservedObject private(set) var viewModel: PopularMovieItemViewModel

    public var body: some View {
        HStack {
            if let poster = viewModel.poster {
                Image(uiImage: poster)
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(12)
                    .frame(width: 73, height: 110)
            } else {
                ProgressView()
                    .frame(width: 73, height: 110)
            }
            Text(viewModel.movie.title)
        }
        .onAppear {
            if let posterPath = viewModel.movie.posterPath,
               let posterURL = URL.movieDBImage(path: posterPath) {

                viewModel.loadImage(url: posterURL)
            }
        }
    }
}

public extension URL {
    enum MovieDBImageType: String {
        case thumb = "w440_and_h660_face"
    }

    static func movieDBImage(
        path: String,
        type: MovieDBImageType = .thumb) -> URL? {

            let baseURL = "https://www.themoviedb.org/t/p/"
            return URL(string: baseURL + type.rawValue + "/" + path)
        }
}


// MARK: - Preview

#if DEBUG
import Domain

struct PopularMovieItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            let viewModel = PopularMovieItemViewModel(
                dependencies: .init(loadImage: { _ in
                    UIImage(named: "matrix")
                }),
                movie: Movie.matrix)
            PopularMovieItemView(viewModel: viewModel)
        }
    }
}
#endif
