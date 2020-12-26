//
//  TrackingListViewModel.swift
//  Covid-19Tracking
//
//  Created by Preston Grisham on 12/26/20.
//

import Foundation
import Combine

class TrackingListViewModel: ObservableObject {
    
    
    @Published var stateData: [TrackingViewModel] = []
    private var cancellable: AnyCancellable?
    
    func getData() {
        cancellable = Webservice.shared.getCovidTrackingResult()
            .receive(on: DispatchQueue.main)
            .compactMap { $0.compactMap(TrackingViewModel.init) }
            .replaceError(with: [])
            .assign(to: \.stateData, on: self)
    }
}

class TrackingViewModel {
    
    var tracking: Tracking
    
    init(tracking: Tracking) {
        self.tracking = tracking
    }
    
    var positive: String {
        tracking.positive.withCommas()
    }
    
    var positiveValue: Int {
        tracking.positive
    }
    
    var total: String {
        tracking.total.withCommas()
    }
    
    var state: String {
        tracking.state
    }
    
    var percentage: String {
        var result = Double(tracking.positive) / Double(tracking.total)
        result = result * 100
        return result.roundTo(decimalPlaces: 1) + "%"
    }
    
    var id = UUID()
    
}
