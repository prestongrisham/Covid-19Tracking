//
//  StateDetailView.swift
//  Covid-19Tracking
//
//  Created by Preston Grisham on 12/26/20.
//

import SwiftUI
import SwiftUICharts

struct StateDetailView: View {
    
    var state: TrackingViewModel
    @StateObject var stateDetailVM = StateDetailViewModel()
        
    var body: some View {
        
        BarChartView(data: ChartData(values: stateDetailVM.dataPoints), title: statesDictionary[state.state]!, form: ChartForm.extraLarge) 
        
//        List(stateDetailVM.stateDetails, id: \.date) { dailyInfo in
//            HStack {
//                Text("\(stateDetailVM.convertToDate(date: dailyInfo.date))  --- ")
//                Text("\(dailyInfo.positiveIncrease!)")
//            }
//        }
        .onAppear(perform: {
            stateDetailVM.getStateDetails(state: state.state)
        })
    }
}

struct StateDetailView_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        let stateData = TrackingViewModel(tracking: Tracking(state: "SC", total: 2876345, positive: 635000, negative: 45000, date: 20201225, death: 4567, hospitalized: 324))
        
        StateDetailView(state: stateData)
    }
}
