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
        RecentTodoEntry(date: Date(), title: "Widget開発", priority: 2)
    }

    func getSnapshot(in context: Context, completion: @escaping (RecentTodoEntry) -> ()) {
        let entry = RecentTodoEntry(date: Date(), title: "Widget開発", priority: 2)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [RecentTodoEntry] = []
        entries.append(RecentTodoEntry(date: Date(), title: "Widget開発", priority: 2))
        let timeline = Timeline(entries: entries, policy: .after(Date().addingTimeInterval(200)))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct RecentTodoEntry: TimelineEntry {
    let date: Date
    let title: String
    let priority: Int
}

// Widgetを表示するView
struct TodoWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .frame(width: .infinity, height: .infinity)
                    .foregroundColor(makePriorityColor(priority: entry.priority))
                    .clipShape(ContainerRelativeShape())
                    .overlay (
                        Text(entry.title)
                            .font(.title)
                            .lineLimit(nil)
                            .foregroundColor(.white)
                    )
            }
            VStack(alignment: .trailing) {
                Text(entry.date, style: .date)
                    .font(.caption)
                    .multilineTextAlignment(.trailing)
                Text(entry.date, style: .time)
                    .font(.caption)
            }
        }
        .padding(8)
    }

    private func makePriorityColor(priority: Int) -> Color {
        switch priority {
            case 0:
                return .green
            case 1:
                return .yellow
            case 2:
                return .red
            default:
                return .black
        }
    }
}

@main
struct TodoWidget: Widget {
    // widgetの種類識別子
    let kind: String = "TodoWidget"

    var body: some WidgetConfiguration {
        // 編集がないWidget
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TodoWidgetEntryView(entry: entry)
        }
        // Widget gallary のタイトル
        .configurationDisplayName("My Widget")
        // Widget gallaryの説明
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

struct TodoWidget_Previews: PreviewProvider {
    static var previews: some View {
        TodoWidgetEntryView(entry: RecentTodoEntry(date: Date(), title: "Widget開発", priority: 2))
            // previewContextでwidgetの大きさをプレビューできる
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
