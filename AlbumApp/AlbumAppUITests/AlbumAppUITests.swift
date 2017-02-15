//
//  AlbumAppUITests.swift
//  AlbumAppUITests
//
//  Created by Ali Darvish on 2/15/17.
//  Copyright © 2017 Sush. All rights reserved.
//

import XCTest

class AlbumAppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.tables.staticTexts["quibusdam saepe ipsa vel harum"].tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).otherElements.children(matching: .image).element.tap()
        
        let image = collectionViewsQuery.children(matching: .cell).element(boundBy: 4).otherElements.children(matching: .image).element
        image.swipeLeft()
        image.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 3).otherElements.children(matching: .image).element.tap()
        XCUIDevice.shared().orientation = .landscapeLeft
        XCUIDevice.shared().orientation = .landscapeLeft
        collectionViewsQuery.children(matching: .cell).element(boundBy: 6).otherElements.children(matching: .image).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 5).otherElements.children(matching: .image).element.tap()
        app.navigationBars["Album Details"].buttons["Albums"].tap()
        
    }
    
}
