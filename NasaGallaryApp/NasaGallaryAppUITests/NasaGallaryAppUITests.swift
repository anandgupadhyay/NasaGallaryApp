//
//  NasaGallaryAppUITests.swift
//  NasaGallaryAppUITests
//
//  Created by Anand Upadhyay on 19/01/23.
//

import XCTest
import NasaGallaryApp

class NasaGallaryAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

class PhotoGallaryUITest: XCTestCase{
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false;
        app.activate()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }
    
    func testCollctionViewExist() throws {
        XCTAssert(app.collectionViews["NasaGallaryCollectionView"].exists)
    }
    
    func testOrienation(){
        (XCUIDevice.shared.orientation = .landscapeLeft)
    }
    
    func testCellExistance() throws {
        XCTAssertTrue(app.collectionViews.element(boundBy: 0).cells.count > 0,"Number of Cell has to be more than 0")
    }
    
    func testCellTapEvent() throws{
        app.collectionViews.element(boundBy: 0).cells.element(boundBy: 0).tap()
    }
    
    func testRefreshGallary() throws{
        app.buttons["Refresh"].tap()
    }
    
    func testBackFromPhotoPageScreen() throws{
        app.collectionViews.element(boundBy: 0).cells.element(boundBy: 0).tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    func testSwipeLeft() throws{
        app.collectionViews.element(boundBy: 0).cells.element(boundBy: 0).tap()
        app.swipeLeft()
    }
    
    func testSwipeRight() throws{
        app.collectionViews.element(boundBy: 0).cells.element(boundBy: 0).tap()
        app.swipeRight()
    }
    
}
