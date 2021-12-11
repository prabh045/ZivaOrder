//
//  zivaorderTests.swift
//  zivaorderTests
//
//  Created by Prabhdeep Singh on 06/12/21.
//

import XCTest
@testable import zivaorder

class zivaorderTests: XCTestCase {
    var sut: GadgetsViewModel!
    var mockRepo: MockProductsRepo!
    var mockCoreDataRepo: CoreDataMockRepo!

    override func setUpWithError() throws {
        let mockRepo = MockProductsRepo()
        let mockCoreData = CoreDataMockRepo()
        self.mockRepo = mockRepo
        self.mockCoreDataRepo = mockCoreData
        sut = GadgetsViewModel(productsRepo: mockRepo, coreDataRepo: mockCoreData)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockRepo = nil
        mockCoreDataRepo = nil
    }

    func testFetchProducs() {
        //Given
        sut.fetchProducts()
        //Then
        XCTAssert(mockRepo.didFetchMethodCalled, "Fetch Products method mustbe called")
    }
    
    func testSuccessRequest() {
        //Given
        sut.fetchProducts()
        //When
        mockRepo.fetchSuccess()
        //Then
        XCTAssert(sut.getProductsCount(section: nil)>0, "Products must not be empty")
    }
    
    func testFailedRequest() {
        //Given
        sut.fetchProducts()
        //When
        mockRepo.fetchFailure()
        //Then
        XCTAssert(sut.getProductsCount(section: nil) == 0, "Products must be empty on failure")
    }
}
