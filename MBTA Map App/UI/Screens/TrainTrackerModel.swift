//
//  TrainTrackerModel.swift
//  MBTA Map App
//
//  Created by Chad Wishner on 1/10/24.
//

import Foundation

class TrainTrackerModel: ObservableObject {
    @Published var trains = [Train]()
    
    init() {
        getTrains(completion: { trains in
            DispatchQueue.main.async {
                print("stopID \(trains.map({ $0.vehicle.stop_id }))")
                
                self.trains = trains
            }
        })
    }
    
    func getTrains(completion: @escaping ([Train]) -> Void){
        let url = URL(string: "https://cdn.mbta.com/realtime/VehiclePositions.json")
        URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
            
            if error != nil {
                print(error as Any)
                return
            }
            
            do {
                guard let data = data else { return completion([]) }
                let mbta = try JSONDecoder().decode(Mbta.self, from: data)
                let trains = mbta.entity.filter({ $0.vehicle.trip?.route_id?.rangeOfCharacter(from: .decimalDigits) == nil })
                let localTrains = trains.filter({ !($0.vehicle.trip?.route_id?.hasPrefix("CR") ?? true) })
                
                completion(localTrains)
            } catch let jsonError {
                print(jsonError)
            }
            
        }.resume()
    }
}
