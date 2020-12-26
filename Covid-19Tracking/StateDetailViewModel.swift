//
//  StateDetailViewModel.swift
//  Covid-19Tracking
//
//  Created by Preston Grisham on 12/26/20.
//

import Foundation
import Combine

class StateDetailViewModel: ObservableObject {
    
    @Published var stateDetails: [StateData] = []
    private var cancellables = Set<AnyCancellable>()
        
    func getStateDetails(state: String) {
        Webservice.shared.getCovidTrackingResultforState(state: state)
            .receive(on: RunLoop.main)
            .replaceError(with: [])
            .print()
            .assign(to: \.stateDetails, on: self)
            .store(in: &cancellables)
        
    }
    
    var mostRecentPositive: String {
        if stateDetails.count > 0 {
            return stateDetails[10].positiveIncrease?.description ?? "No Value"
        } else {
            return "N/A"
        }
    }
    
    var dataPoints: [(String, Int)] {
        stateDetails.reversed().map { (convertToDate(date: $0.date), $0.positiveIncrease ?? 0) }
    }
    
    func convertToDate(date: Int) -> String {
        let dateText = date.description
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.date(from: dateText)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "MM/dd/yyyy"
        
        return dateFormatter2.string(from: date!)
    }
    
}
