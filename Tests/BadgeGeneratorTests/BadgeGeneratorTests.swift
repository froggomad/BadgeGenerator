    import XCTest
    @testable import BadgeGenerator

    final class BadgeGeneratorTests: XCTestCase {
        func testBadgeValueDoesChange() {
            let view = UIView()
            let badge = view.setBadge(in: .southWest, with: "1")
            
            XCTAssertEqual(badge.text, "1")
            badge.text = "2"
            XCTAssertEqual(badge.text, "2")
        }
    }
