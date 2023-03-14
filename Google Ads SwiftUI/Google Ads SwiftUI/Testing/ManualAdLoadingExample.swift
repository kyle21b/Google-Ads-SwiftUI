//
//  ManualAdLoadingView.swift
//  Google Ads SwiftUI
//
//  Created by Kyle Bailey on 3/8/23.
//

import SwiftUI
import GoogleMobileAds

struct ManualAdLoadingExample: View {
    @ObservedObject var adLoader: AdLoader
    @State var currentlyDisplayedAd: GADNativeAd?

    var body: some View {
        VStack {
            let loadedAd = adLoader.loadingStatus.loadedAds?.first
            
            Button("Show Ad") {
                currentlyDisplayedAd = loadedAd
                adLoader.loadingStatus = .notLoaded
            }
            .disabled(loadedAd == nil)
            
            Button("Load Ad") {
                adLoader.loadIfNeeded()
            }
            
            Text(String(describing: adLoader.loadingStatus))
        }
        .buttonStyle(.borderedProminent)
        .animation(.default, value: adLoader.loadingStatus)
        .fullScreenCover(item: $currentlyDisplayedAd) { currentlyDisplayedAd in
            FullscreenNativeAdView(nativeAd: currentlyDisplayedAd, buttonDelay: .seconds(2))
        }
    }
}

struct ManualAdLoadingExample_Previews: PreviewProvider {
    static let nativeTestLoader = AdLoader(GADAdLoader(adUnitID: GADAdLoader.nativeTestLoaderID))
    static let nativeVideoTestLoader = AdLoader(GADAdLoader(adUnitID: GADAdLoader.nativeVideoTestLoaderID))
    
    static var previews: some View {
        ManualAdLoadingExample(adLoader: nativeTestLoader)
        ManualAdLoadingExample(adLoader: nativeVideoTestLoader)
    }
}
