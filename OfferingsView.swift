//
//  OfferingsView.swift
//  RevenueCatTest
//
//  Created by Mogens Egeskov-Madsen on 1/19/20.
//  Copyright © 2020 Mogens Egeskov-Madsen. All rights reserved.
//

import SwiftUI

struct OfferingsView: View {
    @EnvironmentObject var offeringsViewModel: OfferingsViewModel
    @State var selectedIndex = 1

    var body: some View {
        ZStack {
            ForEach(offeringsViewModel.packages.indices, id: \.self) { index in
                VStack {
                    HStack {
                        Text("Package \(index)")
                        Text("\(self.offeringsViewModel.packages[index].localizedPriceString)")
                    }
                }
                .background(self.checkSelection(index: index) ? Color.blue : Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .onTapGesture {
                    self.selectedIndex = index
                }
            }
        }
    }

    func checkSelection(index: Int) -> Bool {
        if self.selectedIndex == index {
            return true
        } else {
            return false
        }
    }
}

struct OfferingsView_Previews: PreviewProvider {
    static var previews: some View {
        OfferingsView()
    }
}
