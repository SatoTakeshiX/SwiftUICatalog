//
//  TodoListViewModelTests.swift
//  TodoReminderTests
//
//  Created by satoutakeshi on 2020/10/03.
//

import XCTest
@testable import TodoReminder

class TodoListViewModelTests: XCTestCase {
    func testGetId() {
        let viewModel = TodoListViewModel()
        XCTContext.runActivity(named: "url") { _ in
            let url = URL(string: "todolist://detail?id=E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!
            if let id = viewModel.getWidgetTodoItem(from: url) {
                XCTAssertEqual(id, UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!)
            } else {
                XCTFail("id is nil")
            }
        }
    }
}
