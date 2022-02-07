import XCTest
import CoreData
import Domain
@testable import LocalPersistence

class DAOMovieAdapterTests: XCTestCase {

    var persistencyController: LocalPersistenceController!

    override func setUpWithError() throws {
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistencyController = LocalPersistenceController(descriptions: [description])
    }

    override func tearDownWithError() throws {
        persistencyController = nil
    }

    func test_createsMovieDAO_fromMovie() throws {
        let movie = Movie.matrix
        let context = persistencyController.context
        let dao = try DAOMovieAdapter.dao(from: .matrix, in: context)

        XCTAssertEqual(dao.identifier, NSNumber(value:movie.id))
        XCTAssertEqual(dao.title, movie.title)
        XCTAssertEqual(dao.overview, movie.overview)
        XCTAssertEqual(dao.releaseDate, movie.releaseDate)
        XCTAssertEqual(dao.posterPath, movie.posterPath)
        XCTAssertEqual(dao.backdropPath, movie.backdropPath)
        XCTAssertEqual(dao.voteAverage, NSNumber(value: movie.voteAverage))
    }
}
