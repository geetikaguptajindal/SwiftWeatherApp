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
        sut?.input.getCities(city: "Vienna")
        sut?.cityPublisher.sink(receiveValue: { cities in
            XCTAssertNotNil(cities)
            XCTAssertEqual(cities.first?.city, "Vienna")
        }).store(in: &cancellable)
    }

    func test_SeachResult_Wrong_With_City_London() {
        sut?.input.getCities(city: "London")
        sut?.cityPublisher.sink(receiveValue: { cities in
            XCTAssertNotNil(cities)
            XCTAssertNotEqual(cities.first?.city, "Vienna")
        }).store(in: &cancellable)
    }
    
    
    func test_SeachResult_Wrong_With_One_Character() {
        sut?.input.getCities(city: "H")
        sut?.errorPublisher.sink(receiveValue: { errorString in
            XCTAssertNotNil(errorString)
            XCTAssertNotEqual(errorString, "InvalidData")
        }).store(in: &cancellable)
    }
}
