//
//  ContentView.swift
//  Covid-19Tracking
//
//  Created by Preston Grisham on 12/26/20.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var trackingListVM = TrackingListViewModel()
    
    var body: some View {
        NavigationView {
            List(trackingListVM.stateData.sorted(by: { $0.positiveValue > $1.positiveValue }), id: \.id) { state in
                
                NavigationLink(
                    destination: StateDetailView(state: state),
                    label: {
                        StateDataCell(state: state)
                    })
            } //: LIST
            .navigationBarTitle("All States")
            .onAppear(perform: {
                trackingListVM.getData()
        })
        } //: NAVIGATION VIEW
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct StateDataCell: View {
    
    var state: TrackingViewModel
    
    var body: some View {
        HStack {
            
            Text(state.state)
                .fontWeight(.bold)
                .modifier(StateLabel())
            
            
            VStack {
                Text(state.positive).numberHeader()
                    .frame(width: 75, height: 25, alignment: .center)
                
                Text("Positive").labelCaption()
            }
            
            Divider().padding([.leading, .trailing], 5)
            
            VStack {
                Text(state.total).numberHeader()
                    .frame(width: 85, height: 25, alignment: .center)
                
                Text("Total").labelCaption()
            }
            
            Divider().padding([.leading, .trailing], 5)
            
            VStack {
                Text(state.percentage).numberHeader()
                
                Text("Total").labelCaption()
                    
            }
                        
        }
    }
}

struct StateLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: 60, height: 50, alignment: .center)
            .background(Rectangle().fill(Color("mainColor")).cornerRadius(10))
            .foregroundColor(.white)
            .padding(.trailing, 20)
            .padding([.top, .bottom], 5)
    }
}

extension Text {
    func numberHeader() -> Text {
        self
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundColor(Color(hue: 1.0, saturation: 0.944, brightness: 0.582))
    }
    
    func labelCaption() -> Text {
        self
            .font(.caption2)
            .fontWeight(.light)
            .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.394))
    }
}
