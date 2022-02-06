//
//  PopularMovies
//

import SwiftUI
import LoadableImage

public struct MovieListItemView: View {

    @ObservedObject private(set) var viewModel: MovieDetailViewModel

    public var body: some View {
        HStack {
            LoadableImage(.init(
                imagePath: viewModel.movie.posterPath,
                loadImageFromPath: { [weak viewModel] path in
                    guard let path = path else { return nil }
                    return try? await viewModel?.loadImageFromPath(path)
                }))
                .scaledToFit()
                .cornerRadius(12)
                .frame(width: 73, height: 110)
            Text(viewModel.movie.title)
            Spacer()
        }
    }
}

// MARK: - Preview

#if DEBUG
import Domain

struct PopularMovieItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            let viewModel = MovieDetailViewModel(.init(
                movie: .matrix,
                loadImageFromPath: { UIImage(named: $0) }))
            MovieListItemView(viewModel: viewModel)
        }
    }
}
#endif
