//
//  TodoWidget.swift
//  TodoWidget
//
//  Created by satoutakeshi on 2020/08/15.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {

    func placeholder(in context: Context) -> RecentTodoEntry {
        RecentTodoEntry(date: Date(), title: "Widget開発", priority: .high, id: UUID())
    }

    func getSnapshot(in context: Context, completion: @escaping (RecentTodoEntry) -> ()) {
        let dummyEntry = RecentTodoEntry(date: Date(), title: "Widget開発", priority: .high, id: UUID())
        let emptyEntry = RecentTodoEntry(date: Date(), title: "Todoはありません", priority: .low, id: UUID())
        if context.isPreview {
            completion(dummyEntry)
        } else {
            do {
                let store = TodoListStore()
                let todoLists = try store.fetchTodayItems()
                let entries = todoLists.map { (todoList) -> RecentTodoEntry in
                    RecentTodoEntry(todoItem: todoList)
                }
                guard let first = entries.first else {
                    completion(emptyEntry)
                    return
                }
                completion(first)
            } catch let error {
                print(error.localizedDescription)
                completion(emptyEntry)
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let emptyEntry = RecentTodoEntry(date: Date(), title: "Todoはありません", priority: .low, id: UUID())
        do {
            let store = TodoListStore()
            let todoLists = try store.fetchTodayItems()
            var entries = todoLists.map { (todoList) -> RecentTodoEntry in
                RecentTodoEntry(todoItem: todoList)
            }
            if entries.isEmpty {
                entries.append(emptyEntry)
            }
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        } catch let error {
            print(error.localizedDescription)
            let timeline = Timeline(entries: [emptyEntry], policy: .atEnd)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct RecentTodoEntry: TimelineEntry {
    let date: Date
    let title: String
    let priority: TodoPriority
    let id: UUID

    init(date: Date, title: String, priority: TodoPriority, id: UUID) {
        self.date = date
        self.title = title
        self.priority = priority
        self.id = id
    }

    init(todoItem: TodoListItem) {
        self.date = todoItem.startDate
        self.title = todoItem.title
        self.priority = todoItem.priority
        self.id = todoItem.id
    }
}

// Widgetを表示するView
struct TodoWidgetEntryView : View, TodoWidgetType {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(makePriorityColor(priority: entry.priority))
                .clipShape(ContainerRelativeShape())
                .overlay (
                    Text(entry.title)
                        .font(.title)
                        .foregroundColor(.white)
                )
            VStack(alignment: .trailing) {
                Text(entry.date, style: .date)
                    .font(.caption)
                Text(entry.date, style: .time)
                    .font(.caption)
            }
        }
        .padding(8)
        .widgetURL(makeURLScheme(id: entry.id))
    }
}

struct TodoWidget: Widget {
    // widgetの種類識別子
    let kind: String = "TodoWidget"

    var body: some WidgetConfiguration {
        // 編集がないWidget
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TodoWidgetEntryView(entry: entry)

        }
        // Widget gallary のタイトル
        .configurationDisplayName("Todo Reminder")
        // Widget gallaryの説明
        .description("直近のTodoListをお知らせします")
        .supportedFamilies([.systemSmall])
    }
}

struct TodoWidget_Previews: PreviewProvider {
    static var previews: some View {
        TodoWidgetEntryView(entry: RecentTodoEntry(date: Date(), title: "Widget開発", priority: .high, id: UUID()))
            // previewContextでwidgetの大きさをプレビューできる
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
