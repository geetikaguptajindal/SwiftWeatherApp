//
//  SearchViewModelTest.swift
//  SwiftWeatherAppTests
//
//  Created by Geetika Gupta on 08/09/23.
//

import XCTest
import Combine

@testable import SwiftWeatherApp

final class SearchViewModelTest: XCTestCase {
    var sut: SearchViewModel?
    private var cancellable = Set<AnyCancellable>()

    override func setUpWithError() throws {
        sut = DefaultSearchViewModel(_defaultSearchUseCases: SearchUseCasesMock(), withCDManager: CityDataRepositoryMock())
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_SeachResult_Correct_With_City_Vienna() {
        let expectation = expectation(description: "City Check Success")

        sut?.cityPublisher.sink(receiveValue: { cities in
            expectation.fulfill()
            XCTAssertNotNil(cities)
            XCTAssertEqual(cities.first?.city, "Vienna")
        }).store(in: &cancellable)
        
        sut?.input.getCities(city: "Vienna")
        
        waitForExpectations(timeout: 2.0)
    }

    func test_SeachResult_Wrong_With_City_London() {
        let expectation = expectation(description: "City Check")
        
        sut?.cityPublisher.sink(receiveValue: { cities in
            expectation.fulfill()
            XCTAssertNotNil(cities)
            XCTAssertNotEqual(cities.first?.city, "Vienna")
        }).store(in: &cancellable)
        
        sut?.input.getCities(city: "London")
        
        waitForExpectations(timeout: 1.0)
    }
    
    
    func test_SeachResult_Wrong_With_One_Character() {
        let expectation = expectation(description: "City Check False")

        sut?.errorPublisher.sink(receiveValue: { errorString in
            expectation.fulfill()
            XCTAssertNotNil(errorString)
            XCTAssertEqual(errorString, "InvalidData")
        }).store(in: &cancellable)
        
        sut?.input.getCities(city: "H")
        
        waitForExpectations(timeout: 1.0)
    }
    
    func test_Record_Save_toDatabase() {
        let isRecordSaved = sut?.saveRecord(cityObj: City(city: "Vienna", country: "Austria"))
        XCTAssertTrue(isRecordSaved ?? false)
    }
}
