//
//  ShowsViewModelTests.swift
//  ShowsAppTests
//
//  Created by Giovanni Luidi Bruno on 30/03/21.
//

import XCTest
@testable import ShowsApp

final class ShowsViewModelTests: XCTestCase {
    
    let didFetchShowsWithSuccessExp = XCTestExpectation(description: "Did fetch shows with success")
    let didFetchShowsWithErrorExp = XCTestExpectation(description: "Did fetch shows with error")
    let timeout: TimeInterval = 30
    
    var viewModel: ShowsViewModel!
    var service: ShowsService!
    var executor = MockHttpExecutor()
    
    override func setUp() {
        super.setUp()
        service = createMockService()
        viewModel = createMockViewModel(coordinator: createMockCoordinator(), service: service)
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        service = nil
    }
    
    private func createMockViewModel(coordinator: ShowsCoordinator, service: ShowsService) -> ShowsViewModel {
        return ShowsViewModel(coordinator: coordinator, service: service, viewDelegate: self)
    }
    
    private func createMockCoordinator() -> ShowsCoordinator {
        return ShowsCoordinator(navigator: MockNavigator(), parent: nil)
    }
    
    private func createMockService() -> ShowsService {
        return ShowsService(executor: executor)
    }
    
    func testFetchSuccess() {
        executor.register(fileName: "fetch-shows-success")
        viewModel.fetchNextPage()
        wait(for: [didFetchShowsWithSuccessExp], timeout: timeout)
        
        XCTAssertEqual(viewModel.numberOfItemsInSection(), 3)
        XCTAssertEqual(viewModel.title, "Shows")
        XCTAssertEqual(viewModel.prefersLargeTitle, true)
    }
    
    
    func testFetchError() {
        executor.register(fileName: String.empty, successCode: false)
        viewModel.fetchNextPage()
        wait(for: [didFetchShowsWithErrorExp], timeout: timeout)
        
        XCTAssertEqual(viewModel.numberOfItemsInSection(), 0)
        XCTAssertEqual(viewModel.errorMessage, "An network error ocurred. Try again later.")
    }
    
}

extension ShowsViewModelTests: ShowsViewDelegate {
    func didFetchShowsWithSuccess() {
        didFetchShowsWithSuccessExp.fulfill()
    }
    
    func didFetchShowsWithError() {
        didFetchShowsWithErrorExp.fulfill()
    }
}

