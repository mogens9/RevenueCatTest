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
        VStack {
            Text("My App Prices")
                .font(.largeTitle)
                .bold()
            ForEach(offeringsViewModel.packages.indices, id: \.self) { index in
                VStack {
                    HStack {
                        Text("Package \(index)")
                        Text("\(self.offeringsViewModel.packages[index].localizedPriceString)")

                        Spacer()
                    }
                }
                .padding()
                .background(self.checkSelection(index: index) ? Color.blue : Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.15), radius: 10, x: 0, y: 10)
                .padding()
                .onTapGesture {
                    self.selectedIndex = index
                }
            }

            Spacer()

            // Buy Button
            Button("Try Free & Subscribe") {
                self.startTrial()
            }
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .foregroundColor(Color.white)
            .font(Font.body.weight(.bold))
            .animation(.spring())
            .padding(.bottom)
        }
    }

    func checkSelection(index: Int) -> Bool {
        if self.selectedIndex == index {
            return true
        } else {
            return false
        }
    }

    func startTrial() {
        self.offeringsViewModel.purchasePackage(package: offeringsViewModel.packages[selectedIndex])
    }
}

struct OfferingsView_Previews: PreviewProvider {
    static var previews: some View {
        OfferingsView()
    }
}
