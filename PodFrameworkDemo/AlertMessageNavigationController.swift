//
//  AlertMessageNavigationController.swift
//  techNuclues-iOS-Swift
//
//  Created by Kishor Kathar on 1/3/19.
//  Copyright © 2019 Comcast. All rights reserved.
//

import Foundation
import UIKit

public class AlertMessageNavigationController:UINavigationController{
  
    private var alertMessageViewController:AlertMessageViewController
    var alertVisualProperties = AlertVisualProperty(alertStyle: .alert)
    
    public var customView:UIView {
        return alertMessageViewController.alertCustomView
    }
    
    var contentView: SimpleAlertView {
        return alertMessageViewController.alertView
    }
    
    init(title: String?, message: String? = nil, attributedMessage: NSAttributedString? = nil, preferredStyle: AlertType?){
        self.alertMessageViewController = AlertMessageViewController(alertTitle: title, alertMessage: message, attributedAlertMessage: attributedMessage, alertType: preferredStyle ?? .none)
        super.init(nibName: nil, bundle: nil)
        self.alertMessageViewController.alertVisualProperties = self.alertVisualProperties
        
        self.setViewControllers([alertMessageViewController], animated: false)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    }
    
    deinit {
        print("Called deinit method from AlertMessageNavigationController")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) public var arrayOfActions = [AlertMessageActions](){
        didSet{self.alertMessageViewController.alertActionArray = self.arrayOfActions}
    }
    
    func addAction(_ action: AlertMessageActions){
        self.arrayOfActions.append(action)
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.isNavigationBarHidden = true
    }
}

// This class is acting like a wrapper over AlertMessageNavigationController. Purpose is not to disclose that navigation controller is used underneath this class.
public class AlertMessageController:AlertMessageNavigationController {
 
  public  init(title: String?, message: String? = nil, attributedMessage: NSAttributedString? = nil, alertType: AlertType?) {
    super.init(title: title, message: message, attributedMessage: attributedMessage, preferredStyle: alertType)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
