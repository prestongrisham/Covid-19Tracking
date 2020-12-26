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
        
        VStack {
            BarChartView(data: ChartData(values: stateDetailVM.dataPoints), title: statesDictionary[state.state]!, form: ChartForm.extraLarge)
                .padding()
            
            Divider()
            
            HStack {
                Text("New Cases per Day")
                    .font(.title)
                    .fontWeight(.black)
                    .padding()
                Spacer()
            }
            
            List(stateDetailVM.stateDetails.prefix(30), id: \.date) { dailyInfo in
                HStack {
                
                    Text("\(stateDetailVM.convertToDate(date: dailyInfo.date)): ")
                        .fontWeight(.bold)
                        .frame(width: 110, height: 35, alignment: .leading)
                    Text("\(dailyInfo.positiveIncrease!)")
                }
            }
            .onAppear(perform: {
                stateDetailVM.getStateDetails(state: state.state)
        })
        }
        .navigationBarTitle(state.state, displayMode: .inline)
    }
}

struct StateDetailView_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        let stateData = TrackingViewModel(tracking: Tracking(state: "SC", total: 2876345, positive: 635000, negative: 45000, date: 20201225, death: 4567, hospitalized: 324))
        
        StateDetailView(state: stateData)
    }
}
