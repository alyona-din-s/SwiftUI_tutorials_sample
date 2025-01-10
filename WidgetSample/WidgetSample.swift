////
////  WidgetSample.swift
////  WidgetSample
////
////  Created by admin_user on 09/01/25.
////
//
import WidgetKit
import SwiftUI
import AppIntents

struct LogWaterIntent: AppIntent {
    static var title: LocalizedStringResource = "Log Water"
    
    func perform() async throws -> some IntentResult {
        let sharedDefaults = UserDefaults(suiteName: "group.com.example.waterapp")
        var count = sharedDefaults?.integer(forKey: "waterCount") ?? 0
        count += 1
        sharedDefaults?.set(count, forKey: "waterCount")
        return .result()
    }
}


@main
struct WaterWidget: Widget {
    let kind: String = "WaterWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WaterProvider()) { entry in
            WaterWidgetView(entry: entry)
        }
        .configurationDisplayName("Water Tracker")
        .description("Track your daily water intake")
        .supportedFamilies([.systemSmall, .systemMedium])
        .contentMarginsDisabled()
    }
}



struct WaterEntry: TimelineEntry {
    let date: Date
    let waterTip: String
    let waterCount: Int
}


struct WaterWidgetView: View {
    var entry: WaterProvider.Entry
    
    var body: some View {
        VStack {
            Text("Water intake: \(entry.waterCount) glasses")
            Button("Log water") {
                // This triggers the intent
            }
            .buttonStyle(.bordered)
        }
    }
}



struct WaterProvider: TimelineProvider {
    func placeholder(in context: Context) -> WaterEntry {
        WaterEntry(date: Date(), waterTip: "Stay hydrated!", waterCount : 0)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WaterEntry) -> ()) {
        let entry = WaterEntry(date: Date(), waterTip: "Drink water regularly", waterCount : 10)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<WaterEntry>) -> ()) {
        let entries = [WaterEntry(date: Date(), waterTip: "Drink 8 glasses of water daily", waterCount : 0)]
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

