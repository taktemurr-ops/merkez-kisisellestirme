// Kişiselleştirme – iOS ana ekran widget'ları (WidgetKit).
// Veri, Flutter tarafında home_widget ile App Group'a yazılır:
//   anahtar "w_<tür>" (clock, date, countdown, note, battery) → JSON
//   { c0, c1, c2, fg (ARGB), title, text, date (ms), days, hours, passed, pick, label }
// Kurulum: ../README.md
import SwiftUI
import UIKit
import WidgetKit

private let appGroup = "group.com.gamestudio100.kisisel"

struct TileData {
    var c0: Color = Color(argb: 0xFF0B1E3F)
    var c1: Color = Color(argb: 0xFF1B3B6F)
    var c2: Color = Color(argb: 0xFF4FD1C5)
    var fg: Color = Color(argb: 0xFF9AE6B4)
    var title = ""
    var text = ""
    var date: Date? = nil
    var days = ""
    var hours = ""
    var passed = ""
    var pick = ""
    var label = ""

    static func load(_ type: String) -> TileData {
        var d = TileData()
        guard let raw = UserDefaults(suiteName: appGroup)?.string(forKey: "w_\(type)"),
              let data = raw.data(using: .utf8),
              let j = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return d }
        func col(_ k: String) -> Color? { (j[k] as? NSNumber).map { Color(argb: $0.uint32Value) } }
        d.c0 = col("c0") ?? d.c0
        d.c1 = col("c1") ?? d.c1
        d.c2 = col("c2") ?? d.c2
        d.fg = col("fg") ?? d.fg
        d.title = j["title"] as? String ?? ""
        d.text = j["text"] as? String ?? ""
        if let ms = (j["date"] as? NSNumber)?.doubleValue, ms > 0 { d.date = Date(timeIntervalSince1970: ms / 1000) }
        d.days = j["days"] as? String ?? ""
        d.hours = j["hours"] as? String ?? ""
        d.passed = j["passed"] as? String ?? ""
        d.pick = j["pick"] as? String ?? ""
        d.label = j["label"] as? String ?? ""
        return d
    }
}

extension Color {
    init(argb: UInt32) {
        self.init(.sRGB,
                  red: Double((argb >> 16) & 0xFF) / 255,
                  green: Double((argb >> 8) & 0xFF) / 255,
                  blue: Double(argb & 0xFF) / 255,
                  opacity: Double((argb >> 24) & 0xFF) / 255)
    }
}

struct TileEntry: TimelineEntry {
    let date: Date
    let data: TileData
}

struct TileProvider: TimelineProvider {
    let type: String
    func placeholder(in context: Context) -> TileEntry { TileEntry(date: Date(), data: TileData()) }
    func getSnapshot(in context: Context, completion: @escaping (TileEntry) -> Void) {
        completion(TileEntry(date: Date(), data: TileData.load(type)))
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<TileEntry>) -> Void) {
        let now = Date()
        let data = TileData.load(type)
        // Saat/tarih metinleri sistem tarafından canlı güncellenir; diğerleri 30 dakikada bir.
        let entries = (0..<4).map { TileEntry(date: now.addingTimeInterval(Double($0) * 1800), data: data) }
        completion(Timeline(entries: entries, policy: .atEnd))
    }
}

struct TileView: View {
    let type: String
    let entry: TileEntry

    var body: some View {
        let d = entry.data
        VStack(spacing: 4) {
            switch type {
            case "clock":
                Text(entry.date, style: .time).font(.system(size: 34, weight: .heavy)).minimumScaleFactor(0.5)
                Text(entry.date, format: .dateTime.weekday(.abbreviated).day().month(.abbreviated))
                    .font(.footnote).opacity(0.8)
            case "date":
                Text(entry.date, format: .dateTime.day()).font(.system(size: 48, weight: .heavy))
                Text(entry.date, format: .dateTime.month(.wide).year()).font(.footnote).opacity(0.8)
            case "countdown":
                if !d.title.isEmpty { Text(d.title).font(.footnote).opacity(0.8).lineLimit(2) }
                if let target = d.date {
                    let diff = target.timeIntervalSince(entry.date)
                    if diff < 0 {
                        Text(d.passed).font(.headline)
                    } else {
                        Text("\(Int(diff / 86400))").font(.system(size: 38, weight: .heavy))
                        Text("\(d.days) · \(Int(diff.truncatingRemainder(dividingBy: 86400) / 3600)) \(d.hours)")
                            .font(.caption).opacity(0.8)
                    }
                } else {
                    Text(d.pick).font(.footnote)
                }
            case "note":
                if !d.title.isEmpty { Text(d.title).font(.footnote).opacity(0.8).lineLimit(2) }
                Text(d.text.isEmpty ? "…" : d.text).font(.headline).lineLimit(5).multilineTextAlignment(.center)
            default:
                let level = UIDevice.current.batteryLevel
                Text(d.label).font(.footnote).opacity(0.8)
                Text(level < 0 ? "—" : "%\(Int(level * 100))").font(.system(size: 38, weight: .heavy))
            }
        }
        .foregroundColor(d.fg)
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .widgetBackground(LinearGradient(colors: [d.c1, d.c0], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

extension View {
    @ViewBuilder
    func widgetBackground<B: View>(_ background: B) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            containerBackground(for: .widget) { background }
        } else {
            self.background(background)
        }
    }
}

struct TileWidget: Widget {
    let kind: String
    let type: String
    let name: LocalizedStringKey

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TileProvider(type: type)) { entry in
            TileView(type: type, entry: entry)
        }
        .configurationDisplayName(name)
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// Flutter tarafı HomeWidget.updateWidget(iOSName: "KisiselWidgets") çağırır;
// WidgetCenter tüm türleri yeniler.
@main
struct KisiselWidgetBundle: WidgetBundle {
    var body: some Widget {
        TileWidget(kind: "KisiselWidgets.clock", type: "clock", name: "w_clock")
        TileWidget(kind: "KisiselWidgets.date", type: "date", name: "w_date")
        TileWidget(kind: "KisiselWidgets.countdown", type: "countdown", name: "w_countdown")
        TileWidget(kind: "KisiselWidgets.note", type: "note", name: "w_note")
        TileWidget(kind: "KisiselWidgets.battery", type: "battery", name: "w_battery")
    }
}
