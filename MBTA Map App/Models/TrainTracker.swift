//
//  TrainTracker.swift
//  MBTA Map App
//
//  Created by Chad Wishner on 1/10/24.
//

import Foundation
import Observation

@MainActor
@Observable
final class TrainTracker {
    private(set) var trains: [TrainLocation] = []
    private(set) var lastError: Error?

    /// Fetches the realtime feed once and updates `trains`.
    func refresh() async {
        do {
            trains = try await MbtaFeed.fetchTrainLocations()
            lastError = nil
        } catch {
            lastError = error
        }
    }

    /// Loops `refresh()` on the given interval until the surrounding Task is cancelled
    /// (e.g. when the hosting view disappears via `.task { ... }`).
    func startPolling(every interval: Duration = .seconds(10)) async {
        while !Task.isCancelled {
            await refresh()
            try? await Task.sleep(for: interval)
        }
    }
}
