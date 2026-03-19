# MBTA Map App

An iOS app and widget that displays realtime MBTA train locations and directions on an interactive map of the Boston transit system.

## Overview

This project tracks live train positions across MBTA rapid transit lines (Red, Orange, Blue, and Green B–E) using the [MBTA realtime feed](https://cdn.mbta.com/realtime/VehiclePositions.json) (GTFS Realtime format). It includes both a standalone app and an iOS home screen widget.

> **Note:** This project is a work in progress and is not yet feature-complete.

## Features

- Fetches realtime vehicle positions from the MBTA API
- Parses GTFS Realtime JSON data including occupancy and multi-car details
- Filters for rapid transit lines (excludes commuter rail)
- iOS widget with hourly timeline updates (`.systemLarge`)
- Live Activity and Dynamic Island support (scaffolded)

## Tech Stack

- **Swift / SwiftUI**
- **WidgetKit** — Home screen widget
- **ActivityKit** — Live Activity / Dynamic Island
- **URLSession** — Networking
- **JSONDecoder** — GTFS Realtime JSON parsing

## Project Structure

```
MBTA Map App/
├── Models/
│   ├── Data.swift          # Train lines, stops, and direction enums
│   ├── Train.swift         # Decodable models for MBTA API response
│   └── ViewModels.swift    # TrainLocation view model
├── UI/
│   ├── Molecules/
│   │   └── MbtaMap.swift   # Map image view
│   └── Screens/
│       └── TrainTrackerModel.swift  # Fetches and publishes train data
├── ContentView.swift
└── MBTA_Map_AppApp.swift

MBTA Map Widget/
├── MBTA_Map_Widget.swift              # Widget timeline provider
├── MBTA_Map_WidgetBundle.swift        # Widget bundle
└── MBTA_Map_WidgetLiveActivity.swift  # Live Activity configuration
```

## Requirements

- iOS 16.1+
- Xcode 14+

## Getting Started

1. Clone the repository.
2. Open `MBTA Map App.xcodeproj` in Xcode.
3. Select a simulator or device and run.

No API key is required — the app uses the public MBTA realtime feed.
