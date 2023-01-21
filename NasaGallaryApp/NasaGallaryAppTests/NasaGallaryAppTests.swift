//
//  NasaGallaryAppTests.swift
//  NasaGallaryAppTests
//
//  Created by Anand Upadhyay on 19/01/23.
//

import XCTest
@testable import NasaGallaryApp

class NasaGallaryAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

class GallaryViewTestCases: XCTestCase {
    
    var nasaPicVm: NasaPictureVM?
    override func setUp(){
        nasaPicVm = NasaPictureVM()
    }
    
    override func tearDown() {
        nasaPicVm = nil
        super.tearDown()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testEmptyData(){
        
        self.nasaPicVm?.mockFetchPhotos(fileName: "EmptyPhotos") { onComplete in
            let rowCount: Int =  self.nasaPicVm?.pictureListModel.value?.count ?? 0
            XCTAssertTrue(rowCount == 0,"No Photos To Show")
        }
    }
    
    func testGetPhotoListFromLocalFile() {
        
        self.nasaPicVm?.mockFetchPhotos(fileName: "NasaPhotos") { onComplete in
            let rowCount: Int =  self.nasaPicVm?.pictureListModel.value?.count ?? 0
            XCTAssertNotNil(self.nasaPicVm?.pictureListModel.value)
            XCTAssert(rowCount > 0, "Total Photos can not be less than 0")
        }
    }
    
    func testGetPhotoListFromLocalApi() {
        
        self.nasaPicVm?.fetchPhotos(params: [:]) { onComplete in
            let rowCount: Int =  self.nasaPicVm?.pictureListModel.value?.count ?? 0
            XCTAssertNotNil(self.nasaPicVm?.pictureListModel.value)
            XCTAssert(rowCount > 0, "Total Photos can not be less than 0")
        }
    }
    
    func testSorting(){
        self.nasaPicVm?.fetchPhotos(params: [:]) { onComplete in
            let rowCount: Int =  self.nasaPicVm?.pictureListModel.value?.count ?? 0
            self.nasaPicVm?.sortPhotosBy(sortKey: NasaPictureElement.CodingKeys.date.rawValue)
            let newRowCount: Int =  self.nasaPicVm?.pictureListModel.value?.count ?? 0
            XCTAssertEqual(rowCount, newRowCount)
        }
    }
    
    func testASinglePhotoExistance() throws {

        self.nasaPicVm?.fetchPhotos(params: [:]) { onComplete in
            XCTAssertNotNil(self.nasaPicVm?.pictureListModel.value)
            let nasaPhoto = self.nasaPicVm?.pictureListModel.value?[0]
            XCTAssertNotNil(nasaPhoto)
        }
    }
    
}

