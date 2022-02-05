import XCTest
@testable import TheMovieDBClient

final class TheMovieDBClientTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(TheMovieDBClient().text, "Hello, World!")
    }
}
