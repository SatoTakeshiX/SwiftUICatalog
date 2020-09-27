//
//  TodoWidget.swift
//  TodoWidget
//
//  Created by satoutakeshi on 2020/08/15.
//

import WidgetKit
import SwiftUI

/*
 /// WidgetKit asks for timeline entries in one of two ways:
 ///
 /// * A single immediate snapshot, representing the widget’s current state.
 /// * An array of entries, including the current moment and, if known, any
 ///    future dates when the widget’s state will change.
 WidgetKitは２つの方法でtimeline entriesを尋ねる。
 素早いsnapshot, 現在の状態を



//https://developer.apple.com/documentation/widgetkit/creating-a-widget-extension
 For an app’s widget to appear in the widget gallery, the user must launch the app that contains the widget at least once after the app is installed.


 ---

 wedgetはgetSnapshotを読んだ後にgetTimelineを呼ぶ

 Important

 Widgets present read-only information and don’t support interactive elements such as scrolling elements or switches. WidgetKit omits interactive elements when rendering a widget’s content.

 https://developer.apple.com/documentation/widgetkit/creating-a-widget-extension

 */

struct Provider: TimelineProvider {
    // これがよくわかってない
    /*
     Display a Placeholder Widget
     When WidgetKit displays your widget for the first time, it renders the widget’s view as a placeholder. A placeholder view displays a generic representation of your widget, giving the user a general idea of what the widget shows. WidgetKit calls placeholder(in:) to request an entry representing the widget’s placeholder configuration. For example, the game status widget would implement this method as follows:


     https://fivestars.blog/code/swiftui-widgetkit.html
     If we have a Text("Five Stars") view, adding a .redacted(reason: .placeholder) modifier replaces the text with a rounded rectangle of the same length of the text, the same color as the text foreground, and some opacity to let the background still show through the rectangle.

     During WWDC this modifier was announced as .isPlaceholder(_:): with the new .redacted(reason:) API, the SwiftUI team can add different placeholder styles (a.k.a. RedactionReasons) in the future.

     Why is this for WidgetKit
     When making widgets, a requirement is to provide a generic preview of our widget to be displayed in the Widget Gallery: the purpose of this gallery is to give a glimpse of the actual widget.

     .redacted(reason:) is perfect for this scenario, as each widget can create its own custom preview, while still being consistent with the rest.

     https://developer.apple.com/forums/thread/655358
     Code Block
     if entry.isPlaceHolderView {
             someView()
                 .redacted(reason: .placeholder)
     } else {
             someView()
     }

     こうかける。

     placeholderでisPlaceHolderViewを渡すようにしよう

     Appleからの回答
     placeholderは同期的な処理。素早く返す必要がある。
     自動的に.redacted(reason: .placeholder)がたされるみたい？
     やりにくいな。本当に自動的になっているのか説明しにくい。
     You should implement placeholder(with: Context) to return a TimelineEntry that contains whatever you need for your placeholder. Note that unlike snapshot and timeline which are asynchronous with a completion block, the placeholder method is synchronous and you return a timeline entry immediately. So you want to be fast to return that entry.

     When your widget's view is rendered for placeholder purposes it's given the placeholder entry and you can render your view accordingly. Note, there's some new SwiftUI support for marking a view as redacted. What should happen is that when WidgetKit renders the widget's view using the placeholder timeline entry, it would automatically render the view using .redacted(reason: .placeholder). Unfortunately that isn't working in Beta 3, but should be fixed in an upcoming seed.
     */


    /**
     0926 追記
        widgetは最初redacted(reason:)でviewを描画して、
     placeholderメソッドのentryを元に描画する。
     同期的な処理になるので、（getSnapshot, get timelineは非同期処理）
     素早く返す必要がある

     .redacted(reason: .placeholder)で描画

     このデータをもとにプレースホルダーを作るという意味か。
     データが増えてUIコンポーネントも増えたら
     */
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(timeIntervalSince1970: 111111))
    }

    // 一時的な状態で呼ばれる。Widgetをユーザーが追加したときなど
    // とくにcontext.isPreviewがtrueならWidget Gallary(small, midium, largeを選ぶところ）で呼ばれていることになる。素早くデータを渡す必要がある
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        // entryはwidgetのviewに渡されるので、view構築に必要なデータをSimpleEntryに定義する
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        // TimelineはWidgetのviewをアップデートする特定の日付を表す型
        // policy .atEndはtimelineの最後に更新する
        // .after(_ data)は指定時間後に更新する
        // .neverは更新しない。　新しいタイムラインが利用可能になったときにアプリがWidgetKitにプロンプ​​トを出すことを指定するポリシー。：タイムラインが更新されたらappがwidgetに通知することで更新させる。
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

// View構築に必要なデータを定義する
// relevanceも定義できる。これを定義するとsmart stackで指定ができる
//https://developer.apple.com/documentation/widgetkit/timelineentryrelevance
struct SimpleEntry: TimelineEntry {
    let date: Date
}

// Widgetを表示するView
struct TodoWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
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
        // .supportedFamiliesがないと自動的に3つの状態でwidgetが提供される。
        //.supportedFamilies(<#T##families: [WidgetFamily]##[WidgetFamily]#>)
    }
}

struct TodoWidget_Previews: PreviewProvider {
    static var previews: some View {
        TodoWidgetEntryView(entry: SimpleEntry(date: Date()))
            // previewContextでwidgetの大きさをプレビューできる
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
