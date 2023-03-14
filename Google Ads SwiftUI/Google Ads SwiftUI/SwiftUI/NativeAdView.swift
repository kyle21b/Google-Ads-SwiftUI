//
//  NativeAdView.swift
//  Google Ads SwiftUI
//
//  Created by Kyle Bailey on 3/9/23.
//

import SwiftUI
import GoogleMobileAds

struct NativeAdView: UIViewRepresentable {
    let nativeAd: GADNativeAd

    func makeUIView(context: Context) -> UINativeAdView {
        Bundle.main.loadNibNamed("UINativeAdView", owner: nil)!.first as! UINativeAdView
    }
    
    func updateUIView(_ uiView: UINativeAdView, context: Context) {
        uiView.update(with: nativeAd)
    }
}

struct NativeAdView_Previews: PreviewProvider {
    static var previews: some View {
        NativeAdView(nativeAd: MockNativeAd(.mockContentOne))
        NativeAdView(nativeAd: MockNativeAd(.mockContentTwo))
    }
}
