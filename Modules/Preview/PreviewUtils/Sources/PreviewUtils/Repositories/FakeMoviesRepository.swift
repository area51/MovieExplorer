//
//  PreviewUtils
//

import Domain
import Combine

public final class FakeMoviesRepository  {
    public var isLoading: CurrentValueSubject<Bool, Never> = .init(false)
    public var movies : CurrentValueSubject<[Movie], Error> = .init([
        .alien,
        .fightclub,
        .matrix,
        .truman
    ])

    public init(
        isLoading: CurrentValueSubject<Bool, Never> = .init(false),
        movies: CurrentValueSubject<[Movie], Error> = .init([.alien, .fightclub, .matrix, . truman])) {

            self.isLoading = isLoading
            self.movies = movies
    }
}
