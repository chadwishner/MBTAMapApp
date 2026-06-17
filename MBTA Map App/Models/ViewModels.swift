//
//  ViewModels.swift
//  MBTA Map App
//
//  Created by Chad Wishner on 1/16/24.
//

import Foundation

/// Shared fetcher for the MBTA realtime feed. Used by both the app's
/// `TrainTracker` and the widget extension's `TimelineProvider`.
enum MbtaFeed {
    static let vehiclePositionsURL = URL(string: "https://cdn.mbta.com/realtime/VehiclePositions.json")!

    static func fetchTrainLocations() async throws -> [TrainLocation] {
        let (data, _) = try await URLSession.shared.data(from: vehiclePositionsURL)
        let mbta = try JSONDecoder().decode(Mbta.self, from: data)
        return mbta.entity.compactMap(TrainLocation.init(train:))
    }
}

/// A `Train` resolved to a known stop on a known line, ready to render on the map.
/// In-transit and incoming trains are snapped forward to `vehicle.stop_id` (the
/// upcoming stop per GTFS), so every `TrainLocation` corresponds to exactly one stop.
struct TrainLocation: Identifiable {
    let id: String
    let line: TrainLine
    let stop: Stops
    let status: VehicleStopStatus
    let direction: Direction

    /// True when the train is physically stopped at `stop`. False when it's approaching
    /// or in transit (still snapped to this stop, but visually distinct).
    var isAtStop: Bool { status == .STOPPED_AT }
}

extension TrainLocation {
    /// Builds a `TrainLocation` from a raw GTFS `Train`. Returns nil if any field
    /// required for rendering is missing or unrecognized (e.g. a stop_id we don't
    /// have mapped, or a non-rapid-transit route).
    init?(train: Train) {
        guard
            let stopIdRaw = train.vehicle.stop_id,
            let stop = Stops(rawValue: stopIdRaw),
            let routeId = train.vehicle.trip?.route_id,
            let line = TrainLine(routeId: routeId),
            let directionRaw = train.vehicle.trip?.direction_id,
            let direction = Direction(rawValue: directionRaw)
        else { return nil }

        self.id = train.id
        self.line = line
        self.stop = stop
        self.status = train.vehicle.current_status ?? .IN_TRANSIT_TO
        self.direction = direction
    }
}
