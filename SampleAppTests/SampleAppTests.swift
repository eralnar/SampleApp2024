//
//  SampleAppTests.swift
//  SampleAppTests
//
//  Created by Diego Manuel Molina Canedo on 24/1/24.
//

import XCTest
@testable import SampleApp

class SampleAppTests: XCTestCase {
    
    let network = NetworkTest.shared
    var characterListCoord: CharacterListCoordinator!
    var characterListVM: CharacterListViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        characterListCoord = CharacterListCoordinator(parent: nil, ramDataInteractor: network)
        characterListVM = characterListCoord.viewModel
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataModelsGetsParsedCorrectly() async throws {
        let result = try await network.getRAMCharacterList(page: 1)
        XCTAssertNotNil(result)
        XCTAssertTrue(result.results.count == 20)
        XCTAssertTrue(result.results[0].name == "Rick Sanchez")
        XCTAssertTrue(result.info.count == 826 && result.info.pages == 42)
        XCTAssertTrue(result.results[0].origin.name == "Earth (C-137)")
    }
    
    func testCharacterListViewModelGetsNextPage() async throws {
        await characterListVM.getNextPage()
        XCTAssert(characterListVM.charactersList.count == 20)
        XCTAssert(characterListVM.nextPage == 2)
    }
    
    func testCharacterListViewModelGetsNext3Pages() async throws {
        await characterListVM.getNextPage()
        await characterListVM.getNextPage()
        await characterListVM.getNextPage()
        XCTAssert(characterListVM.charactersList.count == 60)
        XCTAssert(characterListVM.nextPage == 4)
    }

}
