#if os(Linux)
import XCTest
@testable import SLChatTests

XCTMain([
    testCase(testSLClient.allTests),
     testCase(testSLConnection.allTests),
     testCase(testSLMessage.allTests),
     testCase(testSLService.allTests),
])
#endif
