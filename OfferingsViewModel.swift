//
//  OfferingsViewModel.swift
//  RevenueCatTest
//
//  Created by Mogens Egeskov-Madsen on 1/19/20.
//  Copyright © 2020 Mogens Egeskov-Madsen. All rights reserved.
//

import SwiftUI
import Purchases

class OfferingsViewModel: ObservableObject {
    @Published var packages: [Purchases.Package] = []
    @Published var isSubscribed: Bool = false

    func getOfferings() {
        Purchases.configure(withAPIKey: "YOUR-API-KEY", appUserID: "USER-ID")
        Purchases.shared.offerings { (offerings, error) in
            if let packages = offerings?.current?.availablePackages {
                self.packages = packages
                // Display packages for sale
                print(packages.map { $0.packageType})
                print(packages.map { $0.product.subscriptionPeriod!})
                print(packages.map { $0.product.subscriptionPeriod!.numberOfUnits})
                print(packages.map { $0.product.price})
            }
        }
    }

    func checkIfSubscribed() {
        Purchases.configure(withAPIKey: "YOUR-API-KEY", appUserID: "USER-ID")
        Purchases.shared.purchaserInfo { (purchaserInfo, error) in
            // Access latest purchaserInfo
            if purchaserInfo?.entitlements["ENTITLEMENT-ID"]?.isActive == true {
              // User has access to "your_entitlement_id"
                print("User is subscried")
                self.isSubscribed = true
            } else {
                self.isSubscribed = false
            }
        }
    }

    func purchasePackage(package: Purchases.Package) {
        Purchases.configure(withAPIKey: "YOUR-API-KEY", appUserID: "USER-ID")
        Purchases.shared.purchasePackage(package) { (transaction, purchaserInfo, error, userCancelled) in
            if purchaserInfo?.entitlements.active.first != nil {
                // Unlock that great "pro" content
                print("User bought a package and unlocked content")
                self.isSubscribed = true
            }
            print("\(String(describing: transaction))")
        }
    }
}

