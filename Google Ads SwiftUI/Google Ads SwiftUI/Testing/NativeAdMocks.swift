//
//  NativeAdMocks.swift
//  Google Ads SwiftUI
//
//  Created by Kyle Bailey on 3/7/23.
//

import GoogleMobileAds

extension GADNativeAdImage {
    static let mockImage = GADNativeAdImage(image: .checkmark)
}

class MockMediaContent: GADMediaContent {
    let mockAspectRatio: CGFloat
    init(mockAspectRatio: CGFloat) {
        self.mockAspectRatio = mockAspectRatio
    }
    
    override var aspectRatio: CGFloat { mockAspectRatio }
}

extension GADMediaContent {
    static let mockLandscapeContent = MockMediaContent(mockAspectRatio: 16/9)
    static let mockPortaitContent = MockMediaContent(mockAspectRatio: 9/16)
}

class MockNativeAd: GADNativeAd {
    struct MockContent {
        let headline: String?
        let callToAction: String?
        let icon: GADNativeAdImage?
        let body: String?
        let images: [GADNativeAdImage]?
        let starRating: NSDecimalNumber?
        let store: String?
        let price: String?
        let advertiser: String?
        let mediaContent: GADMediaContent
    }
    
    let mockContent: MockContent
    
    init(_ mockContent: MockContent) {
        self.mockContent = mockContent
    }
    
    override var headline: String? { mockContent.headline }
    override var callToAction: String? { mockContent.callToAction }
    override var icon: GADNativeAdImage? { mockContent.icon }
    override var body: String? { mockContent.body }
    override var images: [GADNativeAdImage]? { mockContent.images }
    override var starRating: NSDecimalNumber? { mockContent.starRating }
    override var store: String? { mockContent.store }
    override var price: String? { mockContent.price }
    override var advertiser: String? { mockContent.advertiser }
    override var mediaContent: GADMediaContent { mockContent.mediaContent }
}

extension MockNativeAd.MockContent {
    static let mockContentOne = MockNativeAd.MockContent(
        headline: "Call of Arms: Medals to Heroes III",
        callToAction: "Download Now!",
        icon: .mockImage,
        body: "Jump into the action. Buy the new hit title now in the app store!",
        images: nil,
        starRating: 5,
        store: "App Store",
        price: "$1.99",
        advertiser: "Long Advertiser name that spans up to two lines of text.",
        mediaContent: .mockLandscapeContent
    )
    
    static let mockContentTwo = MockNativeAd.MockContent(
        headline: "Call of Arms: Medals to Heroes III",
        callToAction: "Download Now!",
        icon: nil,
        body: "Jump into the action. Buy the new hit title now in the app store!",
        images: nil,
        starRating: 2,
        store: "",
        price: nil,
        advertiser: "Long Advertiser name that spans up to two lines of text.",
        mediaContent: .mockPortaitContent
    )
}
