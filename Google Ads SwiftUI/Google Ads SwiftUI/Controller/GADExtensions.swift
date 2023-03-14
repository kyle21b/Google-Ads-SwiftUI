//
//  GADLoaderExtensions.swift
//  Google Ads SwiftUI
//
//  Created by Kyle Bailey on 3/8/23.
//

import Foundation
import GoogleMobileAds

extension GADNativeAd: Identifiable { }

extension GADAdLoader {
    convenience init(adUnitID: String) {
        self.init(
            adUnitID: adUnitID,
            rootViewController: UIApplication.shared.rootViewController,
            adTypes: [.native],
            options: nil
        )
    }
    
    static let nativeTestLoaderID = "ca-app-pub-3940256099942544/2247696110"
    static let nativeVideoTestLoaderID = "ca-app-pub-3940256099942544/1044960115"
}

extension UIApplication {
    var rootViewController: UIViewController? {
        currentKeyWindow?.rootViewController
    }
    
    var currentKeyWindow: UIWindow? {
        connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .filter { $0.isKeyWindow }
            .first
    }
}

