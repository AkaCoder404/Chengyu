//
//  Temp.swift
//  Temp
//
//  Created by George Li on 11/30/24.
//

import WidgetKit
import SwiftUI


struct IdiomEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let idiom: Idiom
}

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> IdiomEntry {
        IdiomEntry(date: Date(),
                    configuration: ConfigurationAppIntent(),
                    idiom: placeHolderIdiom()
        )
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> IdiomEntry {
        IdiomEntry(date: Date(),
                    configuration: configuration,
                    idiom: placeHolderIdiom()
        )
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<IdiomEntry> {
        var entries: [IdiomEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let dailyIdiom = getDailyIdioms().first ?? placeHolderIdiom()
        
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = IdiomEntry(
                date: entryDate,
                configuration: configuration,
                idiom: dailyIdiom
            )
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
        
    }

    func recommendations() -> [AppIntentRecommendation<ConfigurationAppIntent>] {
        // Create an array with all the preconfigured widgets to show.
        [AppIntentRecommendation(intent: ConfigurationAppIntent(), description: "Example Widget")]
    }
}


struct TempEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
//            HStack {
//                Text("Time:")
//                Text(entry.date, style: .time)
//            }
            HStack {
                VStack (alignment: .leading) {
                    Text(entry.idiom.pinyin)
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex:"#676767"))
                    Text(entry.idiom.idiom).font(.system(size:24))
                    Text(entry.idiom.translation)
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex:"#676767"))
                }
                Spacer()
                Image(systemName: "heart")
            }
        }
//        .background(Color(.red))
    }
}

@main
struct Temp: Widget {
    let kind: String = "Temp"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            TempEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .accessoryRectangular) {
    Temp()
} timeline: {
    IdiomEntry(
        date: .now,
        configuration: .smiley,
        idiom: placeHolderIdiom()
    )
    IdiomEntry(
        date: .now,
        configuration: .starEyes,
        idiom: placeHolderIdiom()
    )
}
