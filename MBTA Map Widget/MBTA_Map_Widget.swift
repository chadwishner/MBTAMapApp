//
//  MBTA_Map_Widget.swift
//  MBTA Map Widget
//
//  Created by Chad Wishner on 1/9/24.
//

import WidgetKit
import SwiftUI

struct TrainEntry: TimelineEntry {
    let date: Date
    let trains: [TrainLocation]
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> TrainEntry {
        TrainEntry(date: Date(), trains: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (TrainEntry) -> Void) {
        Task {
            let trains = (try? await MbtaFeed.fetchTrainLocations()) ?? []
            completion(TrainEntry(date: Date(), trains: trains))
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<TrainEntry>) -> Void) {
        Task {
            let trains = (try? await MbtaFeed.fetchTrainLocations()) ?? []
            let now = Date()
            let entry = TrainEntry(date: now, trains: trains)
            // WidgetKit will not honor refreshes faster than ~5 min in practice, even
            // if we ask for less. Re-request once the current entry "expires" so the
            // system schedules the next fetch as soon as it's willing to run one.
            let nextRefresh = now.addingTimeInterval(5 * 60)
            completion(Timeline(entries: [entry], policy: .after(nextRefresh)))
        }
    }
}

struct MBTA_Map_WidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        MbtaMap(trains: entry.trains)
            .ignoresSafeArea()
    }
}

struct MBTA_Map_Widget: Widget {
    let kind: String = "MBTA_Map_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MBTA_Map_WidgetEntryView(entry: entry)
                .containerBackground(.background, for: .widget)
        }
        .configurationDisplayName("MBTA Map")
        .description("Realtime location of every MBTA rapid-transit train.")
        .supportedFamilies([.systemExtraLarge])
        .contentMarginsDisabled()
    }
}

#Preview(as: .systemLarge) {
    MBTA_Map_Widget()
} timeline: {
    TrainEntry(date: .now, trains: [])
}
