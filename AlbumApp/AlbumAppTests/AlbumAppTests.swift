//
//  AlbumAppTests.swift
//  AlbumAppTests
//
//  Created by Ali Darvish on 2/15/17.
//  Copyright © 2017 Sush. All rights reserved.
//

import XCTest
@testable import AlbumApp

class AlbumAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserRequest() {
        let asyncExpectation = expectation(description: "longRunningFunction");
        
        let service: UsersService = UsersService();
        
        service.GET(param: ["id": "1"] as AnyObject, successBlock: { () in
            XCTAssert(true);
            asyncExpectation.fulfill();
        }, failureBlock: { (error) in
            XCTAssert(false);
            asyncExpectation.fulfill();
        });
        
        waitForExpectations(timeout: 10, handler: nil);
    }
    
    func testAlbumRequest() {
        let asyncExpectation = expectation(description: "longRunningFunction");
        
        let service: AlbumsService = AlbumsService();
        
        service.GET(param: ["_page": "1", "_limit": "10"] as AnyObject, successBlock: { (albums) in
            XCTAssert(albums.count == 10);
            
            asyncExpectation.fulfill();
        }, failureBlock: { (error) in
            XCTAssert(false);
            
            asyncExpectation.fulfill();
        });
        
        waitForExpectations(timeout: 10, handler: nil);
    }
    
    func testPhotoAlbumService() {
        let asyncExpectation = expectation(description: "longRunningFunction");
        
        let service = PhotoAlbumService();
        
        service.GET(param: ["albumId": "1"] as AnyObject, successBlock: { (aPhotos) in
            XCTAssert(aPhotos.count == 50);
            
            asyncExpectation.fulfill();
        }, failureBlock: { (error) in
            XCTAssert(false);
            
            asyncExpectation.fulfill();
        });
        
        waitForExpectations(timeout: 10, handler: nil);

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
