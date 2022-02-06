import XCTest
import Domain
import PreviewUtils
@testable import LocalPersistence

final class LocalPersistenceControllerTests: XCTestCase {

    var sut: LocalPersistenceController!

    override func setUpWithError() throws {
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        sut = LocalPersistenceController(descriptions: [description])
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_initSucceeds() {
        XCTAssertNotNil(sut)
    }

    func test_createDAOMovie_andSetTitle() throws {
        let movie = try createMovieDAO()
        let title = "The Matrix"
        movie.title = title
        XCTAssertEqual(movie.title, title)
    }

    func test_initialState_isEmpty() throws {
        XCTAssertEqual(try fetchAllMovies().count, 0)
    }

    func test_addingOneMovie() throws {
        try insert(.matrix)
        XCTAssertEqual(try fetchAllMovies().count, 1)
    }

    func test_addingFourMovie() throws {
        try insert(.alien, .fightclub, .matrix, .truman)
        XCTAssertEqual(try fetchAllMovies().count, 4)
    }

    func test_saving() throws {
        try insert(.alien, .fightclub, .matrix, .truman)

        expectation(
            forNotification: .NSManagedObjectContextDidSave,
            object: sut.context) { _ in return true }

        sut.saveContext()

        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Failed to save context")
        }
    }
}

// MARK: - Test Helpers

extension LocalPersistenceControllerTests {
    enum PersistenceTestError: Error {
        case failedToCreateEntity
    }

    func createMovieDAO() throws -> MovieDAO {
        let entityName = String(describing: MovieDAO.self)

        guard let entity = NSEntityDescription
                .entity(forEntityName: entityName, in: sut.context) else {

                    throw PersistenceTestError.failedToCreateEntity
                }

        return MovieDAO(entity: entity, insertInto: sut.context)
    }

    func insert(_ movies: Movie...) throws {
        try movies.forEach { movie in
            _ = try DAOMovieAdapter.dao(from: movie, in: sut.context)
        }
    }

    func fetchAllMovies() throws -> [NSManagedObject] {
        let entityName = String(describing: MovieDAO.self)
        let fetchRequest = NSFetchRequest<NSManagedObject>(
            entityName: entityName)
        return try sut.context.fetch(fetchRequest)
    }
}
