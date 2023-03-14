//
//  SwiftUINativeAdView.swift
//  Google Ads SwiftUI
//
//  Created by Kyle Bailey on 3/8/23.
//

import SwiftUI
import GoogleMobileAds

struct FullscreenNativeAdView: View {
    let nativeAd: GADNativeAd
    let buttonDelay: Duration
    
    @State var userInteractionEnabled = false
    @State var closeButtonVisible = false
    
    @Environment(\.dismiss) var dismiss

    init(nativeAd: GADNativeAd, buttonDelay: Duration = .seconds(5)) {
        self.nativeAd = nativeAd
        self.buttonDelay = buttonDelay
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Color(white: 0.23)
                .ignoresSafeArea()
                .frame(height: 0)

            NativeAdView(nativeAd: nativeAd)
                .shadow(color: .black.opacity(0.15), radius: 5, y: 8)

            closeButton
                .opacity(closeButtonVisible ? 1 : 0)
                .padding(.top, 35)
                .padding(.bottom, 20)
        }
        .allowsHitTesting(userInteractionEnabled)
        .background {
            Color.black.opacity(0.55)
                .ignoresSafeArea()
        }
        .onAppear {
            Task {
                try await Task.sleep(for: .milliseconds(600))
                userInteractionEnabled = true
            }
            Task {
                try await Task.sleep(for: buttonDelay)
                withAnimation {
                    closeButtonVisible = true
                }
            }
        }
    }
    
    var closeButton: some View {
        Button(action: dismiss.callAsFunction) {
            VStack {
                closeButtonCircle
                closeTextLabel
            }
        }
    }
    
    var closeButtonCircle: some View {
        ZStack {
            Circle()
                .fill(Color(.systemGray3))
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 6)
            Image(systemName: "multiply")
                .foregroundColor(.secondary)
                .font(.system(size: 30, weight: .medium))
        }
        .frame(width: 52, height: 52)
    }
        
    var closeTextLabel: some View {
        Text("Close")
            .font(.system(size: 22, weight: .medium))
            .foregroundColor(.white)
            .shadow(color: .black.opacity(0.8), radius: 12, x: 0, y: 0)
    }
}

struct FullscreenNativeAdView_Previews: PreviewProvider {
    static var previews: some View {
        FullscreenNativeAdView(nativeAd: MockNativeAd(.mockContentOne), buttonDelay: .zero)
        FullscreenNativeAdView(nativeAd: MockNativeAd(.mockContentTwo), buttonDelay: .zero)
    }
}
