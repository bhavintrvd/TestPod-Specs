//
//  AlertMessageActions.swift
//  techNuclues-iOS-Swift
//
//  Created by Kishor Kathar on 1/8/19.
//  Copyright © 2019 Comcast. All rights reserved.
//

import Foundation
import UIKit

public enum AlertActionLayout: Int{
    case auto
    case horizontal
    case verticle
}

public class AlertMessageActions{
    
    public var handler:((AlertMessageActions)->Void)?
    
    var actionView: AlertActionCollectionCell?
    public var title:String?
    public var titleTextColor:UIColor?
    public var titleTextFont:UIFont?
    public var actionBackground:UIColor?
    public var accessibilityIdentifier: String?
    
    public convenience init(actionTitle:String?,handler:((AlertMessageActions)->Void)? = nil){
        self.init()
        self.title = actionTitle
        self.handler = handler
    }
    
    public convenience init(actionTitle:String?,titleColor:UIColor?,handler:((AlertMessageActions)->Void)? = nil){
        self.init()
        self.title = actionTitle
        self.titleTextColor = titleColor
        self.handler = handler
    }
    
    public convenience init(actionTitle:String?,titleColor:UIColor?,titleFont:UIFont?,handler:((AlertMessageActions)->Void)? = nil){
        self.init()
        self.title = actionTitle
        self.titleTextFont = titleFont
        self.titleTextColor = titleColor
        self.handler = handler
    }
    
    public convenience init(actionTitle:String?,titleColor:UIColor?,titleFont:UIFont?,titleBackground:UIColor?,handler:((AlertMessageActions)->Void)? = nil){
        self.init()
        self.title = actionTitle
        self.titleTextFont = titleFont
        self.titleTextColor = titleColor
        self.actionBackground = titleBackground
        self.handler = handler
    }
    
    public convenience init(actionTitle:String?, alertType: AlertType, handler:((AlertMessageActions)->Void)? = nil){
        self.init()
        self.title = actionTitle
        self.titleTextFont = alertType.titleTextFont
        self.titleTextColor = alertType.titleTextColor
        self.actionBackground = alertType.actionBackground
        self.handler = handler
    }
}
