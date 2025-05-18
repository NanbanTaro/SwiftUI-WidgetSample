//
//  WidgetSample.swift
//  WidgetSampleApp
//
//  Created by NanbanTaro on 2025/05/18.
//  
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    // データ取得時などに表示されるWidgetに渡されるデータを返す
    // 所謂、Loading...など
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    // Widget選択画面でのWidgetに渡されるデータを渡す
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "🖐️")
        completion(entry)
    }

    // Widget選択画面で選択された後のデータを返す
    // 次回の更新タイミングも指定する
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct WidgetSampleEntryView : View {
    /// Widgetの種類を取得できる
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry

    var body: some View {
        switch family {
        case .systemSmall:
            Text("systemSmall")
        case .systemMedium:
            Text("systemMedium")
        case .systemLarge:
            Text("systemLarge")
        case .systemExtraLarge:
            Text("systemExtraLarge")
        case .accessoryInline:
            Text("accessoryInline")
        case .accessoryCircular:
            Text("accessoryCircular")
        case .accessoryRectangular:
            Text("accessoryRectangular")
        default:
            Text("default")
        }

//        VStack {
//            Text("Time:")
//            Text(entry.date, style: .time)
//
//            Text("Emoji:")
//            Text(entry.emoji)
//        }
    }
}

struct WidgetSample: Widget {
    let kind: String = "WidgetSample"

    var body: some WidgetConfiguration {
        // 編集なしのwidgetを追加
        // kind: 複数のWidgetを追加できる(アプリ起動からも識別可能)
        // provider: 更新タイミングや表示を指定する
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                WidgetSampleEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                WidgetSampleEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Sample Widget")
        .description("This is an sample widget!!")
        .supportedFamilies(supportedFamilies)
    }

    /// iOS16以上で、ロック画面で表示するウィジェットサイズを追加
    private var supportedFamilies: [WidgetFamily] {
        if #available(iOSApplicationExtension 16.0, *) {
            return [
                .systemSmall,
                .systemMedium,
                .systemLarge,
                .systemExtraLarge,
                .accessoryInline,
                .accessoryCircular,
                .accessoryRectangular
            ]
        } else {
            return [
                .systemSmall,
                .systemMedium,
                .systemLarge
            ]
        }
    }
}

#Preview(as: .systemSmall) {
    WidgetSample()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
