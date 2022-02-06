//
//  PopularMovies
//

import SwiftUI
import Domain
import LoadableImage

public struct MovieDetailView: View {

    private let viewModel: MovieDetailViewModel

    public init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ScrollView {
            VStack {
                LoadableImage(.init(
                    imagePath: viewModel.movie.backdropPath,
                    loadImageFromPath: { [weak viewModel] path in
                        guard let path = path else { return nil }
                        return try? await viewModel?.loadImageFromPath(path)
                    }))
                    .scaledToFit()
                    .frame(maxWidth: .infinity)

                Text(viewModel.movie.title)
                Text(viewModel.movie.overview)
                    .padding()
                Spacer()
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(viewModel: MovieDetailViewModel(.init(
            movie: .matrix,
            loadImageFromPath: { UIImage(named: $0) })))
    }
}
