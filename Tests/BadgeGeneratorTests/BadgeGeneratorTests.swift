    import XCTest
    import BadgeGenerator
    
    final class BadgeGeneratorTests: XCTestCase {
        
        func testBadgeValueDoesChange() {
            
            let badge = sut()
            
            XCTAssertEqual(badge.text, "1")
            badge.text = "2"
            XCTAssertEqual(badge.text, "2")
            
        }
        
        private func sut(direction: BadgeDirection = .northWest, text: String = "1", file: StaticString = #file, line: UInt = #line) -> BadgeLabel {
            
            let view = UIView()
            let badge = view.setBadge(in: direction, with: text)
            
            return badge
            
        }
        
    }
