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
        PriorityEntry(date: Date(), priority: 2, todoList: [])
    }

    func getSnapshot(for configuration: DynamicPrioritySelectionIntent,
                     in context: Context,
                     completion: @escaping (PriorityEntry) -> Void) {

    }

    func getTimeline(for configuration: DynamicPrioritySelectionIntent,
                     in context: Context,
                     completion: @escaping (Timeline<PriorityEntry>) -> Void) {

    }

    func fetchPriority(for configuration: DynamicPrioritySelectionIntent) {
        configuration.priority?.int32Value
        // dbに問い合わせる
        // 返す
        // なかったらデフォルト値 -> Todoはありません
    }
}

struct PriorityEntry: TimelineEntry {
    let date: Date
    let priority: Int
    let todoList: [TodoListItem]
}

struct PriorityWidgetEntryView: View {
    var entry: PriorityProvider.Entry

    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
            case .systemSmall:
                VStack {
                    HStack {
                        VStack {
                            PriorityCircle(priority: entry.priority)
                            Spacer()
                        }
                        VStack(alignment: .leading) {
                            TodoCell(todoTitle: "widget開発")
                            TodoCell(todoTitle: "widget開発")
                            TodoCell(todoTitle: "widget開発")
                            Spacer()
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
                                Text("優先度: 高")
                                    .fontWeight(.bold)
                            }

                            .foregroundColor(.white)
                        )
                    VStack {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("widget開発")
                                Text(Date(), style: .time)
                                    .font(.caption)
                            }

                            Divider()
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("widget開発")
                                Text(Date(), style: .time)
                                    .font(.caption)
                            }
                            Divider()
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("widget開発")
                                Text(Date(), style: .time)
                                    .font(.caption)
                            }

                            Divider()
                        }

                        Text(entry.date, style: .date)
                            .font(.footnote)
                    }
                }
            default:
                EmptyView()
        }
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

    func makeURLScheme(id: UUID) -> URL {
        let url = URL(string: "todolist://detail")!
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [URLQueryItem(name: "id", value: id.uuidString)]
        print("urlcom \(String(describing: urlComponents))")
        return urlComponents!.url!
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

struct PriorityWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PriorityWidgetEntryView(entry: .init(date: Date(), priority: 2, todoList: [TodoListItem(startDate: Date(), note: "", priority: 2, title: "Widget開発")]))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            PriorityWidgetEntryView(entry: .init(date: Date(), priority: 2, todoList: [TodoListItem(startDate: Date(), note: "", priority: 2, title: "Widget開発")]))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}

struct TodoCell: View {
    let todoTitle: String
    var body: some View {
        VStack(spacing: 0) {
            Text(todoTitle)
            Divider()
        }
    }
}

struct PriorityCircle: View {
    let priority: Int
    var body: some View {
        Circle()
            .foregroundColor(makePriorityColor(priority: priority))
            .frame(width: 20, height: 20)
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
