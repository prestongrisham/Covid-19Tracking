//
//  Webservice.swift
//  Covid-19Tracking
//
//  Created by Preston Grisham on 12/26/20.
//

import Foundation
import Combine

class Webservice {
    
    static var shared = Webservice()
    
    func getCovidTrackingResult() -> AnyPublisher< [Tracking], Error > {
        
        guard let url = URL(string: "https://api.covidtracking.com/v1/states/current.json") else { fatalError("Invalid URL") }
        
         return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data}
            .decode(type: [Tracking].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
    }
    
    func getCovidTrackingResultforState(state: String) -> AnyPublisher< [StateData], Error > {
        
        guard let url = URL(string: "https://api.covidtracking.com/v1/states/\(state)/daily.json") else { fatalError("Invalid URL") }
        print(url)
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .print()
            .decode(type: [StateData].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}


extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

extension Double {
    func roundTo(decimalPlaces: Int) -> String {
        return String(format: "%.\(decimalPlaces)f", self) as String
    }
}


var statesDictionary = ["NM": "New Mexico", "SD": "South Dakota", "TN": "Tennessee", "VT": "Vermont", "WY": "Wyoming", "OR": "Oregon", "MI": "Michigan", "MS": "Mississippi", "WA": "Washington", "ID": "Idaho", "ND": "North Dakota", "GA": "Georgia", "UT": "Utah", "OH": "Ohio", "DE": "Delaware", "NC": "North Carolina", "NJ": "New Jersey", "IN": "Indiana", "IL": "Illinois", "HI": "Hawaii", "NH": "New Hampshire", "MO": "Missouri", "MD": "Maryland", "WV": "West Virginia", "MA": "Massachusetts", "IA": "Iowa", "KY": "Kentucky", "NE": "Nebraska", "SC": "South Carolina", "AZ": "Arizona", "KS": "Kansas", "NV": "Nevada", "WI": "Wisconsin", "RI": "Rhode Island", "FL": "Florida", "TX": "Texas", "AL": "Alabama", "CO": "Colorado", "AK": "Alaska", "VA": "Virginia", "AR": "Arkansas", "CA": "California", "LA": "Louisiana", "CT": "Connecticut", "NY": "New York", "MN": "Minnesota", "MT": "Montana", "OK": "Oklahoma", "PA": "Pennsylvania", "ME": "Maine"]
