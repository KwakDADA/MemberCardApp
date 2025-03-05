//
//  DetailViewUITests.swift
//  MemberCardAppUITests
//
//  Created by 권순욱 on 3/5/25.
//

import XCTest

final class DetailViewUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testNavigationToAddEditView() {
        let editButton = app.buttons["편집"]
        XCTAssertTrue(editButton.exists, "편집 버튼이 존재하지 않음")
        
        editButton.tap()
        
        let addEditView = app.buttons["저장"]
        XCTAssertTrue(addEditView.waitForExistence(timeout: 2), "AddEdit 화면으로 이동하지 않음")
    }
    
    func testNavigationToMainView() {
        let deleteButton = app.buttons["삭제"]
        XCTAssertTrue(deleteButton.exists, "삭제 버튼이 존재하지 않음")
        
        deleteButton.tap()
        
        let mainView = app.textViews["멤버"]
        XCTAssertTrue(mainView.waitForExistence(timeout: 2), "삭제 후 메인 화면으로 돌아오지 않음")
    }
    
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//
//        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false
//
//        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
