import XCTest
@testable import Proc

final class ProcTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Proc().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
