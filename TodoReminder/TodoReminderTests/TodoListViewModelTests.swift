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
            let url = URL(string: "todolist://detail?id=123456")!
            if let id = viewModel.getWidgetTodoId(from: url) {
                XCTAssertEqual(id, "123456")
            } else {
                XCTFail("id is nil")
            }
        }
    }
}
