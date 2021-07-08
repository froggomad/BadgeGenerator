    import XCTest
    import BadgeGenerator
    
    final class BadgeGeneratorTests: XCTestCase {
        
        func testBadge_Value_DoesChange() {
            let text = "1"
            let (_, badge) = sut(text: text)
            
            XCTAssertEqual(badge.text, text)
            badge.text = "2"
            XCTAssertEqual(badge.text, "2")
        }
        
        func testBadge_IsRemoved_FromParent() {
            let (view, badge) = sut()
            
            badge.remove()
            XCTAssertFalse(view.subviews.contains(badge))
        }
        
        func testBadgeDirections_MatchExpected_XYCoordinates() {
            let (_, nwBadge) = sut(direction: .northWest)
            XCTAssertEqual(nwBadge.frame.minY, 0)
            XCTAssertEqual(nwBadge.frame.minX, 0)
            
            let (neView, neBadge) = sut(direction: .northEast)
            XCTAssertEqual(neBadge.frame.minY, 0)
            XCTAssertEqual(neBadge.frame.maxX, neView.frame.size.width)
            
            let (swView, swBadge) = sut(direction: .southWest)
            XCTAssertEqual(swBadge.frame.maxY, swView.frame.height)
            XCTAssertEqual(swBadge.frame.minX, 0)
            
            let (seView, seBadge) = sut(direction: .southEast)
            XCTAssertEqual(seBadge.frame.maxY, seView.frame.height)
            XCTAssertEqual(seBadge.frame.maxX, seView.frame.width)
            
            let (centerView, centerBadge) = sut(direction: .center)
            XCTAssertEqual(centerBadge.frame.midX, centerView.bounds.midX, accuracy: 0.2)
        }
        
        func testBadgeTextValue_doesIncrement_withIntValue() {
            let (_, badge) = sut()
            badge.text = "1"
            badge.incrementIntValue(by: 1)
            XCTAssertEqual(badge.text, "2")
        }
        
        func testBadgeTextValue_doesNotIncrement_withNonIntValue() {
            let (_, badge) = sut()
            badge.text = "foo"
            badge.incrementIntValue(by: 1)
            XCTAssertEqual(badge.text, "foo")
        }
        
        func testBadgeTextValue_returnsError_whenIncrementing_withNonIntValue() {
            let (_, badge) = sut()
            badge.text = "foo"
            let badgeResult = badge.incrementIntValue(by: 1)
            switch badgeResult {
            case .success:
                XCTFail("expected failure, got success")
            default:
                break
            }
        }
        
        private func sut(direction: BadgeDirection = .northWest, text: String = "1", file: StaticString = #file, line: UInt = #line) -> (UIView, BadgeLabel) {
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
        // Credit: https://www.essentialdeveloper.com/
        func assertNoMemoryLeak(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
            addTeardownBlock { [weak instance] in
                XCTAssertNil(instance, "Instance should have been deallocated. Potential retain cycle.", file: file, line: line)
            }
        }
    }
