//
//  Temblores_PRTests.swift
//  Temblores PRTests
//
//  Created by Eduardo Moll on 1/11/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import XCTest
@testable import Temblores_PR

class Temblores_PRTests: XCTestCase {
    
    var sut: DetailViewModel!

    override func setUp() {
        
        let properties = EarthquakeProperties(alert: "green",
                                              magnitude: 5.30,
                                              place: "Mock Place",
                                              time: 1578696890535,
                                              title: "Mock Title",
                                              intensity: 3.4)
        
        
        let geometry = EarthquakeGeometry(coordinates: [-66.793400000000005, 17.9297])
        let quake = Earthquake(id: "mockID", properties: properties, geometry: geometry)
        sut = DetailViewModel(earthquake: quake)
    }
    
    func test_alert() {
        XCTAssertEqual(sut.alert, "Green")
    }
    
    func tets_date() {
        XCTAssertEqual(sut.date, "Jan 20, 2020 4:50 p.m.")
    }
    
    func test_deph_noDepthInResponse() {
        XCTAssertNil(sut.depth)
    }
    
    func test_intensity() {
        XCTAssertEqual(sut.intensity, "III")
    }
    
    func test_magnitude() {
        XCTAssertEqual(sut.magnitude, "5.3")
    }
    
    func test_latitude() {
        XCTAssertEqual(sut.latitude, Double("17.9297"))
    }
    
    func test_longitude() {
         XCTAssertEqual(sut.longitude, Double("-66.793400000000005"))
    }
}
