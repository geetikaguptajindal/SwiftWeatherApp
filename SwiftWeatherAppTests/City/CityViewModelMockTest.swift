//
//  CityViewModelMockTest.swift
//  SwiftWeatherAppTests
//
//  Created by Geetika Gupta on 08/09/23.
//

import XCTest
import Combine

@testable import SwiftWeatherApp

final class CityViewModelMockTest: XCTestCase {
    var sut: CityViewModel?
    var sutSearch: SearchViewModel?

    private var cancellable = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        sut = DefaultCityViewModel(withCDManager: CityDataRepositoryMock())
        sutSearch = DefaultSearchViewModel(_defaultSearchUseCases: SearchUseCasesMock(), withCDManager: CityDataRepositoryMock())
    }

    override func tearDownWithError() throws {
        sut = nil
        sutSearch = nil
    }
    
    func test_Record_Fetch_FromDatabase() {
        // save record
        let isRecordSaved = sutSearch?.saveRecord(cityObj: City(city: "Vienna", country: "Austria"))
        XCTAssertTrue(isRecordSaved ?? false)
        
        // fetch
        let expectation = expectation(description: "City Check Success")

        sut?.cityPublisher.sink(receiveValue: { cities in
            expectation.fulfill()
            XCTAssertNotNil(cities)
        }).store(in: &cancellable)

        sut?.getCities()
        waitForExpectations(timeout: 1.0)

    }
    
    func test_Record_Fetch_FromDatabase_If_NoRecord_There() {
        // fetch
        let expectation = expectation(description: "City Check Success")

        sut?.cityPublisher.sink(receiveValue: { cities in
            expectation.fulfill()
            XCTAssertEqual(cities.count, 0)
        }).store(in: &cancellable)

        sut?.getCities()
        waitForExpectations(timeout: 1.0)
    }
}
