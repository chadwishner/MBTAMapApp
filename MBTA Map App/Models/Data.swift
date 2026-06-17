//
//  Data.swift
//  MBTA Map App
//
//  Created by Chad Wishner on 1/9/24.
//

import Foundation
import CoreGraphics

enum TrainLine {
    case orange
    case greenB
    case greenC
    case greenD
    case greenE
    case red
    case blue

    init?(routeId: String) {
        switch routeId {
        case "Orange":  self = .orange
        case "Red":     self = .red
        case "Blue":    self = .blue
        case "Green-B": self = .greenB
        case "Green-C": self = .greenC
        case "Green-D": self = .greenD
        case "Green-E": self = .greenE
        default: return nil
        }
    }
}

enum Stops: String {
    case reservoir
    case forestHills
    case backBay
    case northStation
    case wonderland
    case magounSquare
    case orientHeights
    case harvard
    case bowdoin
    case unionSquare
    case centralAvenue
    case packardsCorner
    case bostonCollege
    case alewife
    case summitAvenue
    case downtownCrossing
    case beachmont
    case broadway
    case woodIsland
    case tappanStreet
    case babcockStreet
    case allstonStreet
    case warrenStreet
    case stonyBrook
    case butler
    case fieldsCorner
    case southStation
    case charlesMgh
    case davis
    case airport
    case newtonHighland
    case valleyRoad
    case central
    case clevelandCircle
    case fenway
    case ashmont
    case sullivanSquare
    case oakGrove
    case northQuincy
    case aquarium
    case kenmore
    case roxburyCrossing
    case andrew
    case state
    case assembly
    case quincyAdams
    case beaconsfield
    case braintree
    case wollaston
    case wellington
    case chestnutHill
    case sciencePark
    case medfordTufts
    case waban
    case brandonHall
    case woodland
    case parkStreet
    case communityCollege
    case porter
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case "70175": self = .reservoir
        case "70014", "70015": self = .backBay
        case "70206": self = .northStation
        case "70059", "70060": self = .wonderland
        case "70508": self = .magounSquare
        case "70052": self = .orientHeights
        case "70067": self = .harvard
        case "70838": self = .bowdoin
        case "Union Square-02": self = .unionSquare
        case "70270": self = .centralAvenue
        case "70134": self = .packardsCorner
        case "70106", "70107": self = .bostonCollege
        case "70061", "Alewife-02": self = .alewife
        case "70223", "70224": self = .summitAvenue
        case "70021": self = .downtownCrossing
        case "70055": self = .beachmont
        case "70081", "70082": self = .broadway
        case "70049": self = .woodIsland
        case "70231": self = .tappanStreet
        case "170136": self = .babcockStreet
        case "70127": self = .allstonStreet
        case "70124": self = .warrenStreet
        case "70005": self = .stonyBrook
        case "70265", "70513": self = .butler
        case "70089", "70090": self = .fieldsCorner
        case "70080": self = .southStation
        case "70073": self = .charlesMgh
        case "70063": self = .davis
        case "70048": self = .airport
        case "70168", "70169": self = .newtonHighland
        case "70271": self = .valleyRoad
        case "70069", "70070": self = .central
        case "70237": self = .clevelandCircle
        case "70186": self = .fenway
        case "70093": self = .ashmont
        case "70031": self = .sullivanSquare
        case "Oak Grove-02": self = .oakGrove
        case "70098": self = .northQuincy
        case "70043": self = .aquarium
        case "70150": self = .kenmore
        case "70008": self = .roxburyCrossing
        case "70083": self = .andrew
        case "70022", "70042": self = .state
        case "70279": self = .assembly
        case "70104": self = .quincyAdams
        case "70176": self = .beaconsfield
        case "Braintree-02": self = .braintree
        case "70099": self = .wollaston
        case "70032": self = .wellington
        case "70113": self = .chestnutHill
        case "70207", "70208": self = .sciencePark
        case "70511": self = .medfordTufts
        case "70165": self = .waban
        case "70226": self = .brandonHall
        case "70162": self = .woodland
        case "Forest Hills-02": self = .forestHills
        case "70076": self = .parkStreet
        case "70028": self = .communityCollege
        case "70066": self = .porter
        default: return nil
        }
    }
}

enum Direction: Int {
    case northOrEast = 0
    case southOrWest = 1
}
extension Stops {
    /// Position of the stop on the Map asset, expressed as a fraction of the image's
    /// width/height (0...1). Multiply by the rendered image size to get pixel coordinates.
    var normalizedPoint: CGPoint {
        switch self {
        case .reservoir:         return CGPoint(x: 0, y: 0)
        case .forestHills:       return CGPoint(x: 0, y: 0)
        case .backBay:           return CGPoint(x: 0, y: 0)
        case .northStation:      return CGPoint(x: 0, y: 0)
        case .wonderland:        return CGPoint(x: 0, y: 0)
        case .magounSquare:      return CGPoint(x: 0, y: 0)
        case .orientHeights:     return CGPoint(x: 0, y: 0)
        case .harvard:           return CGPoint(x: 0, y: 0)
        case .bowdoin:           return CGPoint(x: 0, y: 0)
        case .unionSquare:       return CGPoint(x: 0, y: 0)
        case .centralAvenue:     return CGPoint(x: 0, y: 0)
        case .packardsCorner:    return CGPoint(x: 0, y: 0)
        case .bostonCollege:     return CGPoint(x: 0, y: 0)
        case .alewife:           return CGPoint(x: 0, y: 0)
        case .summitAvenue:      return CGPoint(x: 0, y: 0)
        case .downtownCrossing:  return CGPoint(x: 0, y: 0)
        case .beachmont:         return CGPoint(x: 0, y: 0)
        case .broadway:          return CGPoint(x: 0, y: 0)
        case .woodIsland:        return CGPoint(x: 0, y: 0)
        case .tappanStreet:      return CGPoint(x: 0, y: 0)
        case .babcockStreet:     return CGPoint(x: 0, y: 0)
        case .allstonStreet:     return CGPoint(x: 0, y: 0)
        case .warrenStreet:      return CGPoint(x: 0, y: 0)
        case .stonyBrook:        return CGPoint(x: 0, y: 0)
        case .butler:            return CGPoint(x: 0, y: 0)
        case .fieldsCorner:      return CGPoint(x: 0, y: 0)
        case .southStation:      return CGPoint(x: 0, y: 0)
        case .charlesMgh:        return CGPoint(x: 0, y: 0)
        case .davis:             return CGPoint(x: 0, y: 0)
        case .airport:           return CGPoint(x: 0, y: 0)
        case .newtonHighland:    return CGPoint(x: 0, y: 0)
        case .valleyRoad:        return CGPoint(x: 0, y: 0)
        case .central:           return CGPoint(x: 0, y: 0)
        case .clevelandCircle:   return CGPoint(x: 0, y: 0)
        case .fenway:            return CGPoint(x: 0, y: 0)
        case .ashmont:           return CGPoint(x: 0, y: 0)
        case .sullivanSquare:    return CGPoint(x: 0, y: 0)
        case .oakGrove:          return CGPoint(x: 0, y: 0)
        case .northQuincy:       return CGPoint(x: 0, y: 0)
        case .aquarium:          return CGPoint(x: 0, y: 0)
        case .kenmore:           return CGPoint(x: 0, y: 0)
        case .roxburyCrossing:   return CGPoint(x: 0, y: 0)
        case .andrew:            return CGPoint(x: 0, y: 0)
        case .state:             return CGPoint(x: 0, y: 0)
        case .assembly:          return CGPoint(x: 0, y: 0)
        case .quincyAdams:       return CGPoint(x: 0, y: 0)
        case .beaconsfield:      return CGPoint(x: 0, y: 0)
        case .braintree:         return CGPoint(x: 0, y: 0)
        case .wollaston:         return CGPoint(x: 0, y: 0)
        case .wellington:        return CGPoint(x: 0, y: 0)
        case .chestnutHill:      return CGPoint(x: 0, y: 0)
        case .sciencePark:       return CGPoint(x: 0, y: 0)
        case .medfordTufts:      return CGPoint(x: 0, y: 0)
        case .waban:             return CGPoint(x: 0, y: 0)
        case .brandonHall:       return CGPoint(x: 0, y: 0)
        case .woodland:          return CGPoint(x: 0, y: 0)
        case .parkStreet:        return CGPoint(x: 0, y: 0)
        case .communityCollege:  return CGPoint(x: 0, y: 0)
        case .porter:            return CGPoint(x: 0, y: 0)
        }
    }
}

