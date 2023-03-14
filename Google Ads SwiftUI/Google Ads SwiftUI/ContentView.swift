//
//  ContentView.swift
//  Google Ads SwiftUI
//
//  Created by Kyle Bailey on 3/7/23.
//

import SwiftUI
import GoogleMobileAds

struct ContentView: View {
    @StateObject var adLoader = AdLoader(GADAdLoader(adUnitID: GADAdLoader.nativeVideoTestLoaderID))
    var body: some View {
        ManualAdLoadingExample(adLoader: adLoader)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
