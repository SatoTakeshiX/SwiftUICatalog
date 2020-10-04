//
//  PriorityWidget.swift
//  TodoWidgetExtension
//
//  Created by satoutakeshi on 2020/10/03.
//

import WidgetKit
import SwiftUI

struct PriorityProvider: IntentTimelineProvider {
    typealias Intent = DynamicPrioritySelectionIntent
    typealias Entry = PriorityEntry

    func placeholder(in context: Context) -> PriorityEntry {
        dummyPriorityEntry
    }

    func getSnapshot(for configuration: DynamicPrioritySelectionIntent,
                     in context: Context,
                     completion: @escaping (PriorityEntry) -> Void) {
        if context.isPreview {
            completion(dummyPriorityEntry)
        } else {
            let todoList = try! fetchPriority(for: configuration)
            guard let priorityValue = configuration.priority?.intValue,
                  let priority = TodoPriority(rawValue: priorityValue) else {
                // todoはありません
                let entry = PriorityEntry(date: Date(), priority: .low, todoList: [])
                completion(entry)
                return
            }
            let entry = PriorityEntry(date: Date(), priority: priority, todoList: todoList)
            completion(entry)
        }
    }

    func getTimeline(for configuration: DynamicPrioritySelectionIntent,
                     in context: Context,
                     completion: @escaping (Timeline<PriorityEntry>) -> Void) {

        do {
            let todoList = try fetchPriority(for: configuration)
            let dividedTodoList = divideByThree(todoList: todoList)
            var entries: [PriorityEntry] = []
            dividedTodoList.forEach { (todoList) in
                if let lastTodo = todoList.last {
                    entries.append(PriorityEntry(date: lastTodo.startDate, priority: lastTodo.priority, todoList: todoList))
                }
            }
            let timeLine = Timeline(entries: entries, policy: .atEnd)
            completion(timeLine)
        } catch {
            let entry = PriorityEntry(date: Date(), priority: .low, todoList: [])
            let timeLine = Timeline(entries: [entry], policy: .never)
            completion(timeLine)
            print(error.localizedDescription)
        }
    }

    func fetchPriority(for configuration: DynamicPrioritySelectionIntent) throws -> [TodoListItem] {
        if let priorityValue = configuration.priority?.intValue {
            let store = TodoListStore()
            do {
                let todoList = try store.fetchTodayItems(by: priorityValue)
                return todoList
            } catch {
                print(error.localizedDescription)
                throw error
            }
        } else {
            throw CoreDataStoreError.fetchError(reason: "no priority value")
        }
    }

    // 3つずつ区切る
    func divideByThree(todoList: [TodoListItem]) -> [[TodoListItem]] {
        var dividedTodoList: [[TodoListItem]] = []
        var startRange = 0
        var endRange = 3
        while todoList.count >= endRange {
            let new = todoList[startRange ..< endRange]
            dividedTodoList.append(Array(new))
            startRange += 3
            if endRange + 3 > todoList.count {
                endRange += todoList.count % 3
            } else {
                endRange += 3
            }
        }
        return dividedTodoList
    }
}

struct PriorityEntry: TimelineEntry {
    let date: Date
    let priority: TodoPriority
    let todoList: [TodoListItem]
}

struct PriorityWidgetEntryView: View, TodoWidgetType {
    var entry: PriorityProvider.Entry

    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
            case .systemSmall:
                VStack {
                    if entry.todoList.isEmpty {
                        Text("今日のTodoはありません")
                            .padding(.bottom)
                    } else {
                        HStack {
                            VStack {
                                PriorityCircle(priority: entry.priority)
                                Spacer()
                            }
                            VStack(alignment: .leading) {
                                ForEach(entry.todoList) { todoItem in
                                    TodoCell(todoTitle: todoItem.title)
                                }
                                Spacer()
                            }
                        }
                    }

                    Text(entry.date, style: .date)
                        .font(.footnote)
                }
                .padding(.all)
            case .systemMedium:
                HStack {
                    Rectangle()
                        .foregroundColor(makePriorityColor(priority: entry.priority))
                        .overlay(
                            VStack {
                                Text("今日のTodo")
                                    .fontWeight(.bold)
                                Text("優先度: \(entry.priority.name)")
                                    .fontWeight(.bold)
                            }

                            .foregroundColor(.white)
                        )
                    if entry.todoList.isEmpty {
                        Text("今日のTodoはありません")
                            .padding()
                    } else {
                        VStack {
                            ForEach(entry.todoList) { todoItem in
                                TodoMediumCell(todoTitle: todoItem.title, startDate: todoItem.startDate)

                            }
                            Text(entry.date, style: .date)
                                .font(.footnote)
                        }
                    }
                }
            default:
                EmptyView()
        }
    }
}

struct PriorityWidget: Widget {
    let kind: String = "PriorityWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: DynamicPrioritySelectionIntent.self, provider: PriorityProvider()) { entry in
            PriorityWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Priority Sort")
        .description("今日のTodoを優先度ごとに表示")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

let dummyTodoItem: TodoListItem = .init(startDate: Date(),
                                        note: "",
                                        priority: .high,
                                        title: "Widget開発")

let dummyPriorityEntry: PriorityEntry = .init(date: Date(),
                                              priority: .high,
                                                todoList: [dummyTodoItem,
                                                           dummyTodoItem,
                                                           dummyTodoItem
                                                ])

let dummyEmptyEntry: PriorityEntry = .init(date: Date(), priority: .low, todoList: [])

struct PriorityWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PriorityWidgetEntryView(entry: dummyPriorityEntry)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            PriorityWidgetEntryView(entry: dummyPriorityEntry)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            PriorityWidgetEntryView(entry: dummyEmptyEntry)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            PriorityWidgetEntryView(entry: dummyEmptyEntry)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}

struct TodoCell: View {
    let todoTitle: String
    var body: some View {
        VStack(spacing: 4) {
            Text(todoTitle)
                .font(.callout)
            Divider()
        }
    }
}

struct TodoMediumCell: View {
    let todoTitle: String
    let startDate: Date
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(todoTitle)
                Text(startDate, style: .time)
                    .font(.caption)
            }
            Divider()
        }
    }
}

struct PriorityCircle: View, TodoWidgetType {
    let priority: TodoPriority
    var body: some View {
        Circle()
            .foregroundColor(makePriorityColor(priority: priority))
            .frame(width: 20, height: 20)
    }
}
