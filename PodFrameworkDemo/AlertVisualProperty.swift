//
//  AlertVisualProperty.swift
//  techNuclues-iOS-Swift
//
//  Created by Kishor Kathar on 1/9/19.
//  Copyright © 2019 Comcast. All rights reserved.
//

import Foundation
import UIKit

class AlertVisualProperty : NSObject{
    
    // Properties for alert title color and title font
    public var titleLabelTextColor:UIColor = UIColor.black
    public var titleLabelFont:UIFont = UIFont.systemFont(ofSize: 24.0)//Constants.Font.xfinitySansMed.getUIFontForSize(24.0)
    
    // Properties for alert message color and title font
    public var messageLabelTextColor:UIColor = UIColor.black
    public var messageLabelFont:UIFont = UIFont.systemFont(ofSize: 16.0)
    
    // Properties for alert view background
    public var alertViewBackground:UIColor = UIColor.white
    
     public var actionViewSize = CGSize(width: 90, height: 44)
    
    
     public var verticalSpacing: CGFloat = 15
    public var imageVerticalSpacing : CGFloat = 32
    public var titleVerticalSpacing : CGFloat = 32
    public var messageVerticalSpacing : CGFloat = 16
    public var messageWidth : CGFloat = 252
    public var scrollViewBottomSpacing : CGFloat = 64
    public var leadingTrailingMessageSpacing : CGFloat = 30
    
    private let alertStyle: AlertMessagessControllerStyle
    public var margins: UIEdgeInsets
    public var width: CGFloat
    public var contentPadding = UIEdgeInsets(top: 36, left: 16, bottom: 12, right: 16)
   
    public init(alertStyle: AlertMessagessControllerStyle) {
        self.alertStyle = alertStyle
        
        switch alertStyle {
        case .alert:
            if #available(iOS 11, *), let keyWindow = UIApplication.shared.keyWindow,keyWindow.safeAreaInsets.bottom > 0 {
                self.margins = .zero
            } else {
                self.margins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
            }
            
            self.width = 270
            self.actionViewSize = CGSize(width: 90, height: 44)
        }
    }
}
