//
//  Tracking.swift
//  Covid-19Tracking
//
//  Created by Preston Grisham on 12/26/20.
//

import Foundation

struct Tracking: Decodable {
    
    var state: String
    var total: Int
    var positive: Int
    var negative: Int
    var date: Int
    var death: Int
    var hospitalized: Int?    
}

struct StateData: Decodable {
    var date: Int
    var positiveIncrease: Int?
}
