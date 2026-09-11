//
//  DemoContentView.swift
//  DuoLikeAnimation
//

import SwiftUI

/// A busy, colorful screen so the reprojection and blur are easy to read.
///
/// Everything here is pure SwiftUI on purpose: UIKit-backed views (ScrollView, List, TextField)
/// are not rasterized into a `layerEffect` layer and would vanish under the shader.
struct DemoContentView: View {
    private let columns = [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
                header
                chips
                heroCard
                LazyVGrid(columns: columns, spacing: 12) {
                    StatTile(title: "Steps", value: "8,412", symbol: "figure.walk", tint: .green)
                    StatTile(title: "Sleep", value: "7h 20m", symbol: "moon.zzz.fill", tint: .indigo)
                    StatTile(title: "Focus", value: "3h 05m", symbol: "brain.head.profile", tint: .orange)
                    StatTile(title: "Water", value: "1.8 L", symbol: "drop.fill", tint: .cyan)
                }
                Text("Recent")
                    .font(.title3.weight(.semibold))
                VStack(spacing: 0) {
                    ForEach(Array(rows.enumerated()), id: \.offset) { index, row in
                        ListRow(row: row)
                        if index < rows.count - 1 { Divider().padding(.leading, 60) }
                    }
                }
                .background(.background.secondary, in: .rect(cornerRadius: 16))
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(.systemGroupedBackground))
    }

    private var header: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Wednesday, 10 Sep")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("Today")
                    .font(.largeTitle.bold())
            }
            Spacer()
            Circle()
                .fill(LinearGradient(colors: [.pink, .orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 44, height: 44)
                .overlay { Text("ES").font(.headline).foregroundStyle(.white) }
        }
    }

    private var chips: some View {
        HStack(spacing: 8) {
            ForEach(["All", "Health", "Work", "Reading", "Travel", "Music"], id: \.self) { label in
                Text(label)
                    .font(.subheadline.weight(.medium))
                    .lineLimit(1)
                    .fixedSize()
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(label == "All" ? Color.accentColor : Color(.secondarySystemGroupedBackground), in: .capsule)
                    .foregroundStyle(label == "All" ? .white : .primary)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .clipped()
    }

    private var heroCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "sparkles")
                Text("Frosted glass fold")
                Spacer()
                Image(systemName: "arrow.up.right")
            }
            .font(.headline)
            Text("Tilt the phone around its vertical axis. The interface stays put in space while the screen becomes a tilted pane of frosted glass.")
                .font(.subheadline)
                .opacity(0.9)
            HStack(spacing: 6) {
                ForEach(0..<12, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 3)
                        .fill(.white.opacity(0.85))
                        .frame(height: CGFloat(18 + (index * 37) % 46))
                }
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
        }
        .foregroundStyle(.white)
        .padding(18)
        .background(
            LinearGradient(colors: [.blue, .purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing),
            in: .rect(cornerRadius: 20)
        )
    }

    private struct Row {
        let title: String
        let subtitle: String
        let symbol: String
        let tint: Color
    }

    private let rows: [Row] = [
        Row(title: "Morning run", subtitle: "5.2 km · 27 min", symbol: "figure.run", tint: .green),
        Row(title: "Design review", subtitle: "10:30 · Room 4B", symbol: "calendar", tint: .red),
        Row(title: "Flight to Lisbon", subtitle: "Fri 18:45 · Gate 22", symbol: "airplane", tint: .blue),
        Row(title: "Read 20 pages", subtitle: "The Left Hand of Darkness", symbol: "book.fill", tint: .brown),
    ]

    private struct ListRow: View {
        let row: Row
        var body: some View {
            HStack(spacing: 14) {
                Image(systemName: row.symbol)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 34, height: 34)
                    .background(row.tint, in: .rect(cornerRadius: 8))
                VStack(alignment: .leading, spacing: 2) {
                    Text(row.title).font(.body.weight(.medium))
                    Text(row.subtitle).font(.footnote).foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.tertiary)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
        }
    }
}

private struct StatTile: View {
    let title: String
    let value: String
    let symbol: String
    let tint: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: symbol).foregroundStyle(tint)
                Text(title).font(.subheadline).foregroundStyle(.secondary)
                Spacer()
            }
            Text(value).font(.title2.weight(.semibold))
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background.secondary, in: .rect(cornerRadius: 16))
    }
}

#Preview {
    DemoContentView()
}
