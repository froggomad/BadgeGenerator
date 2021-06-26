    import XCTest
    import BadgeGenerator
    
    final class BadgeGeneratorTests: XCTestCase {
        
        func testBadgeValueDoesChange() {
            let text = "1"
            let (_, badge) = sut(text: text)
            
            XCTAssertEqual(badge.text, text)
            badge.text = "2"
            XCTAssertEqual(badge.text, "2")
        }
        
        func testBadgeDoesNotLeak() {
            let (_, badge) = sut()
            
            badge.remove()
            assertNoMemoryLeak(badge)
        }
        
        private func sut(direction: BadgeDirection = .northWest, text: String = "1", file: StaticString = #file, line: UInt = #line) -> BadgeLabel {
            let view = UIView()
            view.bounds.size.width = 100
            view.bounds.size.height = view.bounds.size.width
            let badge = view.setBadge(in: direction, with: text)
            
            view.setNeedsLayout()
            view.layoutIfNeeded()
            badge.setNeedsLayout()
            badge.layoutIfNeeded()
            
            assertNoMemoryLeak(view, file: file, line: line)
            assertNoMemoryLeak(badge, file: file, line: line)
            
            return (view, badge)
        }
        
    }
    
    extension XCTestCase {
        func assertNoMemoryLeak(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
            addTeardownBlock { [weak instance] in
                XCTAssertNil(instance, "Instance should have been deallocated. Potential retain cycle.", file: file, line: line)
            }
        }
    }
