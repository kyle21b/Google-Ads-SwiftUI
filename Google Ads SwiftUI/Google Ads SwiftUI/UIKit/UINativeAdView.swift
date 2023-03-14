//
//  UINativeAdView.swift
//  Google Ads SwiftUI
//
//  Created by Kyle Bailey on 3/7/23.
//

import UIKit
import GoogleMobileAds

class UINativeAdView: GADNativeAdView {
    var mediaHeightConstraint: NSLayoutConstraint?

    @IBOutlet weak var starRatingPaddingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var iconWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var iconPaddingConstraint: NSLayoutConstraint!
}

extension UINativeAdView {
    func update(with nativeAd: GADNativeAd) {
        configureMediaView(with: nativeAd)
        
        configureInfoContainer(with: nativeAd)

        let bodyView = bodyView as? UILabel
        bodyView?.text = nativeAd.body
        
        configureButtons(with: nativeAd)

        self.nativeAd = nativeAd
    }

    func configureMediaView(with nativeAd: GADNativeAd) {
        mediaView?.mediaContent = nativeAd.mediaContent
      
        mediaHeightConstraint?.isActive = false
       
        let aspectRatio = nativeAd.mediaContent.aspectRatio
        
        guard let mediaView, aspectRatio > 0 else { return }
            
        mediaHeightConstraint = NSLayoutConstraint(
            item: mediaView,
            attribute: .height,
            relatedBy: .equal,
            toItem: mediaView,
            attribute: .width,
            multiplier: 1/aspectRatio,
            constant: 0
        )
        
        mediaHeightConstraint?.priority = UILayoutPriority(999)
        mediaHeightConstraint?.isActive = true
    }

    func configureInfoContainer(with nativeAd: GADNativeAd) {
        let iconView = iconView as? UIImageView
        let iconImage = nativeAd.icon?.image
        let iconHidden = iconImage == nil

        iconView?.image = iconImage
        iconView?.isHidden = iconHidden
        
        iconPaddingConstraint.constant = iconHidden ? 0 : 8
        iconWidthConstraint.constant = iconHidden ? 0 : 64
        
        let headlineView = headlineView as? UILabel
        let headline = nativeAd.headline ?? ""
        
        headlineView?.text = headline
        headlineView?.isHidden = headline.isEmpty
        
        let advertiserView = advertiserView as? UILabel
        let advertiser = nativeAd.advertiser ?? ""
        let advertiserHidden = advertiser.isEmpty
        
        advertiserView?.text = advertiser
        advertiserView?.isHidden = advertiserHidden
        
        let starRatingView = starRatingView as? UIImageView
        let starRatingImage = nativeAd.starRating.flatMap(UIImage.imageForStars(numberOfStars:))
        let starRatingHidden = starRatingImage == nil
        
        starRatingView?.image = starRatingImage
        starRatingView?.isHidden = starRatingHidden
        
        starRatingPaddingConstraint.constant = starRatingHidden || advertiserHidden ? 0 : 8
    }

    func configureButtons(with nativeAd: GADNativeAd) {
        let storeView = storeView as? UILabel
        let store = nativeAd.store ?? ""
        storeView?.text = store
        storeView?.isHidden = store.isEmpty
        
        let priceView = priceView as? UILabel
        let price = nativeAd.price ?? ""
        priceView?.text = price
        priceView?.isHidden = price.isEmpty
        
        let callToActionView = callToActionView as? UIButton
        let callToAction = nativeAd.callToAction ?? ""
        callToActionView?.setTitle(callToAction, for: .normal)
        callToActionView?.isHidden = callToAction.isEmpty
        callToActionView?.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        callToActionView?.isUserInteractionEnabled = false
    }
}

extension UIImage {
    static func imageForStars(numberOfStars: NSDecimalNumber) -> UIImage? {
        switch numberOfStars.doubleValue {
        case 5...: return UIImage(named: "stars_5")
        case 4.5...: return UIImage(named: "stars_4_5")
        case 4...: return UIImage(named: "stars_4")
        case 3.5...: return UIImage(named: "stars_3_5")
        default: return nil
        }
    }
}

