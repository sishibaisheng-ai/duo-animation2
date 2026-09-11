//
//  ContentView.swift
//  DuoLikeAnimation
//
//  Created by Elijah Semyonov on 10/09/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var motion = FoldMotionModel()
    @State private var showsControls = false

    var body: some View {
        GeometryReader { proxy in
            let insets = proxy.safeAreaInsets
            DemoContentView()
                .safeAreaPadding(insets)
                // Pin the shaded layer to the physical screen: the shader places the eye at the
                // center of its bounds, so content overflowing the screen would shift the geometry.
                .frame(width: proxy.size.width + insets.leading + insets.trailing,
                       height: proxy.size.height + insets.top + insets.bottom)
                .clipped()
                .foldEffect(angle: motion.tiltAngle)
                .ignoresSafeArea()
        }
        .overlay(alignment: .bottomTrailing) { controls }
        .onAppear { motion.start() }
        .onDisappear { motion.stop() }
    }

    private var controls: some View {
        VStack(alignment: .trailing, spacing: 10) {
            if showsControls {
                controlPanel
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            Button {
                withAnimation(.snappy) { showsControls.toggle() }
            } label: {
                Image(systemName: showsControls ? "xmark" : "slider.horizontal.3")
                    .font(.headline)
                    .frame(width: 44, height: 44)
            }
            .buttonStyle(.plain)
            .background(.ultraThinMaterial, in: .circle)
        }
        .padding()
    }

    private var controlPanel: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(motion.tiltAngle * 180 / .pi, format: .number.precision(.fractionLength(1)))
                    .monospacedDigit()
                Text("°")
                Spacer()
                Button("Recalibrate", systemImage: "scope") { motion.recalibrate() }
                    .disabled(motion.usesManualTilt || !motion.isMotionAvailable)
            }
            .font(.subheadline.weight(.medium))

            Toggle("Manual tilt", isOn: $motion.usesManualTilt)
                .disabled(!motion.isMotionAvailable)

            Slider(value: $motion.manualDegrees, in: -45...45, step: 0.5) {
                Text("Tilt")
            } minimumValueLabel: {
                Text("-45°").font(.caption2)
            } maximumValueLabel: {
                Text("45°").font(.caption2)
            }
            .disabled(!motion.usesManualTilt)
        }
        .padding(16)
        .frame(width: 280)
        .background(.ultraThinMaterial, in: .rect(cornerRadius: 20))
    }
}

#Preview {
    ContentView()
}
