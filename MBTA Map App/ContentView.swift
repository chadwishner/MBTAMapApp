//
//  ContentView.swift
//  MBTA Map App
//
//  Created by Chad Wishner on 1/9/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = TrainTrackerModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
