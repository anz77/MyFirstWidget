//
//  OtherWidget.swift
//  OtherWidget
//
//  Created by ANDRII ZUIOK on 24.12.2020.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
        
    let savedImages: [Int: UIImage] = [:]
    let configuration: MyWidgetConfiguration = MyWidgetConfiguration(sizeType: .smallSize, layoutType: .zeroLayout, imageUrls: [:])
        
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), images: [:], layoutType: configuration.layoutType)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), images: savedImages, layoutType: configuration.layoutType)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = getEntry()
        let repeatTime = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
        let timeline = Timeline(entries: [entry], policy: .after(repeatTime))
        completion(timeline)
    }
    
    func getEntry() -> SimpleEntry {
        guard let userDefaults = UserDefaults(suiteName: "group.zuiokandrii.myapp"),
              let fetchedEncodedConfiguration = userDefaults.object(forKey: "widgetConfiguration") as? Data,
              let fetchedConfiguration = try? PropertyListDecoder().decode(MyWidgetConfiguration.self, from: fetchedEncodedConfiguration) else { return SimpleEntry(date: Date(), images: savedImages, layoutType: configuration.layoutType)}
        var images: [Int : UIImage] = [:]
        fetchedConfiguration.imageUrls.forEach { (key, value) in
            if let imageData = try? Data(contentsOf: value),
               let uiImage = UIImage(data: imageData) {
                images[key] = uiImage
            }
        }
        return SimpleEntry(date: Date(), images: images, layoutType: fetchedConfiguration.layoutType)
    }
    
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    let images: [Int: UIImage]
    let layoutType: LayoutType
}

struct OtherWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

struct WidgetView : View {
    @Environment(\.widgetFamily) var family
    
    var entry: SimpleEntry

    @ViewBuilder
    var body: some View {
        
        switch family {
        case .systemSmall:
            LayoutFrameView(entry: entry, sizeType: .smallSize, blancColor: .systemGray6)
        case .systemMedium:
            LayoutFrameView(entry: entry, sizeType: .mediumSize, blancColor: .systemGray6)
        case .systemLarge:
            LayoutFrameView(entry: entry, sizeType: .largeSize, blancColor: .systemGray6)
        default:
            Text("Some other WidgetFamily in the future.")
        }

    }
}

@main
struct OtherWidget: Widget {
    
    @Environment(\.widgetFamily) var family
    
    let kind: String = "OtherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetView(entry: entry)//LayoutFrameView(entry: entry, blancColor: .systemGray6)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemLarge, .systemSmall, .systemMedium])
    }
}

struct OtherWidget_Previews: PreviewProvider {
    static var previews: some View {
        LayoutFrameView(entry: SimpleEntry(date: Date(), images: [:], layoutType: .firstLayout), sizeType: .smallSize, blancColor: .systemGray6)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
