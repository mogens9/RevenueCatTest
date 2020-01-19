//
//  ContentView.swift
//  RevenueCatTest
//
//  Created by Mogens Egeskov-Madsen on 1/19/20.
//  Copyright © 2020 Mogens Egeskov-Madsen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var offeringsViewModel: OfferingsViewModel

    var body: some View {
        // If user is subscribed it will show Hello, World!
        // else it will show the packages for sale (Pay wall)
        ZStack {
            if offeringsViewModel.isSubscribed {
                Text("Hello, World!")
            } else {
                OfferingsView()
            }
        }.onAppear {
            // Fetching offerings/packages for sale
            self.offeringsViewModel.getOfferings()
            // Checking if user has subscribed
            self.offeringsViewModel.checkIfSubscribed()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
