//
//  GITHUB_ISSUETests.swift
//  GITHUB ISSUETests
//
//  Created by Naba Riaz on 9/9/22.
//

import XCTest
@testable import GITHUB_ISSUE

class GITHUB_ISSUETests: XCTestCase {

    var vm: IssueViewModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        vm = IssueViewModel()
        
        let objUser = User(login: "login")
        let objIssue = Issue(url: "url", title: "title", user: objUser, state: "state", comments: 1, created_at: "09-12-2022")
        
        vm?.arr = [objIssue]
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.

        vm = nil
    }
    
    //vm methods tests
    func testGetRowCount() {
        let count = vm?.getRowCount()
        XCTAssertEqual(count, 1)
    }
    
    func testGetDataForCell(row: Int) {
        let result = vm?.getDataForCell(row: 0)
        XCTAssertNil(result)
    }
}
