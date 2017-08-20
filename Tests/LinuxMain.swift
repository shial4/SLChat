#if os(Linux)
import XCTest
@testable import SLChatTests

XCTMain([
    testCase(SLClientTests.allTests),
     testCase(SLConnectionTests.allTests),
     testCase(SLMessageTests.allTests),
     testCase(SLServiceTests.allTests),
])
#endif
