//
//  AutomaticAdLoadingView.swift
//  Google Ads SwiftUI
//
//  Created by Kyle Bailey on 3/8/23.
//

import SwiftUI
import GoogleMobileAds

struct AutomaticAdLoadingExample: View {
    @ObservedObject var adLoader: AdLoader
    @State var loadedAd: GADNativeAd?
    
    var body: some View {
        Group {
            if let loadedAd {
                FullscreenNativeAdView(nativeAd: loadedAd, buttonDelay: .zero)
            } else {
                Color.black.opacity(0.55)
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            adLoader.loadIfNeeded()
        }
        .onChange(of: adLoader.loadingStatus) { newValue in
            loadedAd = newValue.loadedAds?.first
        }
    }
}

struct AutomaticAdLoadingExample_Previews: PreviewProvider {
    static let nativeTestLoader = AdLoader(GADAdLoader(adUnitID: GADAdLoader.nativeTestLoaderID))
    static let nativeVideoTestLoader = AdLoader(GADAdLoader(adUnitID: GADAdLoader.nativeVideoTestLoaderID))
    
    static var previews: some View {
        AutomaticAdLoadingExample(adLoader: nativeTestLoader)
        AutomaticAdLoadingExample(adLoader: nativeVideoTestLoader)
    }
}
