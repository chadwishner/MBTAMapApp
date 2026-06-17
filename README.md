# MBTA Map App

An iOS Home Screen widget (with companion app) that plots every MBTA rapid-transit train on a map of the Boston transit system in near real time.

## Overview

The widget renders the MBTA system map and overlays a colored dot for each active train on the Red, Orange, Blue, and Green (B–E) lines. Positions come from the public [MBTA realtime feed](https://cdn.mbta.com/realtime/VehiclePositions.json) (GTFS Realtime, JSON encoding).

The companion app is primarily a host/installer for the widget — it explains what the widget does and walks the user through adding it to their Home Screen.

> **Note:** This project is a work in progress. Stop coordinates on the map are still being calibrated.

## Features

- Fetches realtime vehicle positions from the MBTA GTFS Realtime feed
- Parses occupancy, multi-car details, position, and trip metadata
- Filters to rapid-transit routes only (no commuter rail or bus)
- Snaps each train to its upcoming stop and renders it as a colored dot on the map
- Visually distinguishes trains that are *stopped at* a station from those *in transit / incoming*
- Home Screen widget in Large (iPhone & iPad) and Extra Large (iPad) sizes
- Shared fetcher used by both the in-app tracker and the widget timeline provider

## Tech Stack

- **Swift / SwiftUI**
- **Observation** — `@Observable` view models (iOS 17+)
- **Swift Concurrency** — `async/await`, `Task`, `Duration`-based polling
- **WidgetKit** — Home Screen widget with `TimelineProvider`
- **URLSession** + **JSONDecoder** — Networking and GTFS Realtime JSON parsing

## Project Structure

```
MBTA Map App/
├── MBTA Map App/                  # App target
│   ├── Models/
│   │   ├── Train.swift            # Decodable GTFS Realtime models
│   │   ├── Data.swift             # TrainLine, Stops, Direction enums + map coordinates
│   │   ├── ViewModels.swift       # MbtaFeed fetcher + TrainLocation render model
│   │   └── TrainTracker.swift     # @Observable poller for the live app
│   ├── UI/
│   │   └── MbtaMap.swift          # Map image with overlaid train dots
│   ├── ContentView.swift          # App landing screen / widget install guide
│   └── MBTA_Map_AppApp.swift      # App entry point
│
└── MBTA Map Widget/               # Widget extension target
    ├── MBTA_Map_Widget.swift      # TimelineProvider + widget entry view
    └── MBTA_Map_WidgetBundle.swift
```

### Data flow

1. `MbtaFeed.fetchTrainLocations()` (in `ViewModels.swift`) downloads `VehiclePositions.json`, decodes it into `Mbta` / `Train`, and maps each entity into a `TrainLocation`. Trains on unmapped stops or non-rapid-transit routes are dropped.
2. In the app, `TrainTracker` (`@Observable`) calls `refresh()` in a loop via `startPolling(every:)` — default cadence is every 10 seconds, cancelled with the hosting view's `.task`.
3. In the widget, `Provider` calls the same `MbtaFeed` from `getTimeline`, building a single entry and asking WidgetKit to refresh after ~5 minutes (the practical floor for widget refreshes).
4. `MbtaMap` renders the system map image and overlays a `Circle` per train, positioned using `Stops.normalizedPoint` (0…1 coordinates) scaled to the rendered image size.

## Requirements

- iOS 17+ (uses the Observation framework)
- Xcode 15+
- iPhone or iPad — Large widget works on both; Extra Large is iPad-only

## Getting Started

1. Clone the repository.
2. Open `MBTA Map App.xcodeproj` in Xcode.
3. Select a simulator or device and run.
4. Long-press the Home Screen → **+** → search for **MBTA Map** → add the Large or Extra Large widget.

No API key is required — the app uses the public MBTA realtime feed.
