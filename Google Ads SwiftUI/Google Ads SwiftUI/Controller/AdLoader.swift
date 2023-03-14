//
//  AdLoader.swift
//  Google Ads SwiftUI
//
//  Created by Kyle Bailey on 3/8/23.
//

import Foundation
import GoogleMobileAds

class AdLoader: NSObject, ObservableObject {
    enum LoadingStatus: Equatable {
        case notLoaded
        case loading([GADNativeAd])
        case loaded([GADNativeAd], Date)
        case failed(NSError, Date)
    }
    
    let adLoader: GADAdLoader

    @Published var loadingStatus: LoadingStatus = .notLoaded
    
    init(_ adLoader: GADAdLoader) {
        self.adLoader = adLoader
        super.init()
        adLoader.delegate = self
    }
}

extension AdLoader: GADNativeAdLoaderDelegate {
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
        nativeAd.delegate = self

        switch loadingStatus {
        case .loading(let ads):
            loadingStatus = .loading(ads + [nativeAd])
        default:
            invariantFailure()
        }
    }
    
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
        loadingStatus = .failed(error as NSError, .now)
    }
    
    func adLoaderDidFinishLoading(_ adLoader: GADAdLoader) {
        switch loadingStatus {
        case .loading(let ads):
            loadingStatus = .loaded(ads, .now)
        default:
            invariantFailure()
        }
    }
    
    func invariantFailure() {
        loadingStatus = .notLoaded
    }
}

extension AdLoader {
    static let maxAdAge: TimeInterval = 60 * 60
    static let errorRetryTime: TimeInterval = 60
    
    func loadIfNeeded() {
        let currentTime = Date.now
        switch loadingStatus {
        case .loaded(_, let loadTime) where currentTime.timeIntervalSince(loadTime) >= AdLoader.maxAdAge: fallthrough
        case .failed(_, let loadTime) where currentTime.timeIntervalSince(loadTime) >= AdLoader.errorRetryTime: fallthrough
        case .notLoaded:
            loadingStatus = .loading([])
            adLoader.load(request)
        default: return
        }
    }
    
    private var request: GADRequest {
        return GADRequest()
    }
}

extension AdLoader.LoadingStatus {
    var loadedAds: [GADNativeAd]? {
        switch self {
        case .loaded(let ads, let loadingTime) where Date.now.timeIntervalSince(loadingTime) < AdLoader.maxAdAge:
            return ads
        default:
            return nil
        }
    }
}

extension AdLoader: GADNativeAdDelegate {
    func nativeAdDidRecordImpression(_ nativeAd: GADNativeAd) {
      // The native ad was shown.
        print("nativeAdDidRecordImpression(_:)")
    }

    func nativeAdDidRecordClick(_ nativeAd: GADNativeAd) {
      // The native ad was clicked on.
        print("nativeAdDidRecordClick(_:)")
    }

    func nativeAdWillPresentScreen(_ nativeAd: GADNativeAd) {
      // The native ad will present a full screen view.
        print("nativeAdWillPresentScreen(_:)")
    }

    func nativeAdWillDismissScreen(_ nativeAd: GADNativeAd) {
      // The native ad will dismiss a full screen view.
        print("nativeAdWillDismissScreen(_:)")
    }

    func nativeAdDidDismissScreen(_ nativeAd: GADNativeAd) {
      // The native ad did dismiss a full screen view.
        print("nativeAdDidDismissScreen(_:)")
    }

    func nativeAdWillLeaveApplication(_ nativeAd: GADNativeAd) {
      // The native ad will cause the application to become inactive and
      // open a new application.
        print("nativeAdWillLeaveApplication(_:)")
    }
}
