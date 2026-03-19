//
//  Train.swift
//  MBTA Map App
//
//  Created by Chad Wishner on 1/9/24.
//

import Foundation

/*
 Data types based on JSON data returned by https://cdn.mbta.com/realtime/VehiclePositions.json
 This data is based on Google's GTFS documentation
 */

struct Mbta: Decodable {
    var header: Header
    var entity: [Train]
}

struct Header: Decodable {
    var gtfs_realtime_version: String
    var incrementality: String
    var timestamp: Int
}

struct Train: Decodable {
    var id: String
    var vehicle: Vehicle
}

struct Vehicle: Decodable {
    var current_status: VehicleStopStatus?
    var current_stop_sequence: Int?
    var multi_carriage_details: [CarraigeDetails]?
    var occupancy_percentage: Int?
    var occupancy_status: String?
    var position: Position?
    var stop_id: String?
    var timestamp: Int?
    var trip: TripDescriptor?
    var vehicle: VehicleDescriptor?
}

struct CarraigeDetails: Decodable {
    var carriage_sequence: Int?
    var label: String?
    var occupancy_percentage: Int?
    var occupancy_status: String?
}

struct Position: Decodable {
    var bearing: Double?
    var latitude: Double?
    var longitude: Double?
    var odometer: Double?
    var speed: Double?
}

struct TripDescriptor: Decodable {
    var direction_id: Int?
    var route_id: String?
    var schedule_relationship: ScheduleRelationship?
    var start_date: String?
    var start_time: String?
    var trip_id: String?
}

struct VehicleDescriptor: Decodable {
    var id: String?
    var label: String?
}

enum VehicleStopStatus: String, Decodable {
    case INCOMING_AT
    case STOPPED_AT
    case IN_TRANSIT_TO
}

enum ScheduleRelationship: String, Decodable {
    case SCHEDULED
    case ADDED
    case UNSCHEDULED
    case CANCELED
}

/* Example JSON Obect for Train
 {
    "id":"O-547A5440",
    "vehicle":{
       "current_status":"STOPPED_AT",
       "current_stop_sequence":10,
       "multi_carriage_details":[
          {
             "carriage_sequence":1,
             "label":"1476",
             "occupancy_percentage":10,
             "occupancy_status":"FEW_SEATS_AVAILABLE"
          },
          {
             "carriage_sequence":2,
             "label":"1477",
             "occupancy_percentage":7,
             "occupancy_status":"MANY_SEATS_AVAILABLE"
          },
          {
             "carriage_sequence":3,
             "label":"1490",
             "occupancy_percentage":4,
             "occupancy_status":"MANY_SEATS_AVAILABLE"
          },
          {
             "carriage_sequence":4,
             "label":"1491",
             "occupancy_percentage":17,
             "occupancy_status":"FEW_SEATS_AVAILABLE"
          },
          {
             "carriage_sequence":5,
             "label":"1475",
             "occupancy_percentage":11,
             "occupancy_status":"FEW_SEATS_AVAILABLE"
          },
          {
             "carriage_sequence":6,
             "label":"1474",
             "occupancy_percentage":12,
             "occupancy_status":"FEW_SEATS_AVAILABLE"
          }
       ],
       "position":{
          "bearing":200,
          "latitude":42.42673,
          "longitude":-71.07438
       },
       "stop_id":"70034",
       "timestamp":1704823314,
       "trip":{
          "direction_id":0,
          "route_id":"Orange",
          "schedule_relationship":"SCHEDULED",
          "start_date":"20240109",
          "start_time":"12:59:00",
          "trip_id":"60455415"
       },
       "vehicle":{
          "id":"O-547A5440",
          "label":"1476"
       }
    }
 },
 */
