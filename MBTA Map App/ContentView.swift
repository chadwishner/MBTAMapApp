//
//  ContentView.swift
//  MBTA Map App
//
//  Created by Chad Wishner on 1/9/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    header
                    aboutSection
                    instructionsSection
                    notesSection
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 24)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationTitle("MBTA Map")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: "tram.fill")
                .font(.system(size: 44))
                .foregroundStyle(.tint)
            Text("MBTA Map Widget")
                .font(.largeTitle.bold())
            Text("A Home Screen widget that shows the real-time location of every MBTA rapid-transit train.")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }

    private var aboutSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 12) {
                Label("Live positions for the Red, Orange, Blue, and Green lines.", systemImage: "location.fill")
                Label("Refreshes automatically in the background.", systemImage: "arrow.clockwise")
                Label("Available in Large and Extra Large sizes.", systemImage: "square.grid.2x2.fill")
            }
            .font(.body)
        } header: {
            sectionHeader("What it does")
        }
    }

    private var instructionsSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 16) {
                instructionRow(number: 1, text: "Touch and hold an empty area of your Home Screen until the apps jiggle.")
                instructionRow(number: 2, text: "Tap the **+** button in the upper-left corner.")
                instructionRow(number: 3, text: "Search for **MBTA Map** and select it.")
                instructionRow(number: 4, text: "Tap **Add Widget**.")
                instructionRow(number: 5, text: "Tap **Done** to finish.")
            }
        } header: {
            sectionHeader("Add the widget")
        }
    }

    private var notesSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 10) {
                Text("iOS limits how often widgets can refresh, so train positions typically update every few minutes rather than instantly.")
                Text("Extra Large widgets are supported on iPad only.")
            }
            .font(.footnote)
            .foregroundStyle(.secondary)
        } header: {
            sectionHeader("Good to know")
        }
    }

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.title2.bold())
            .padding(.bottom, 4)
    }

    private func instructionRow(number: Int, text: String) -> some View {
        HStack(alignment: .top, spacing: 14) {
            Text("\(number)")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(width: 28, height: 28)
                .background(Circle().fill(Color.accentColor))
            Text(.init(text))
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
