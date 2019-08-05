//
//  AlertMessageViewController.swift
//  techNuclues-iOS-Swift
//
//  Created by Kishor Kathar on 1/7/19.
//  Copyright © 2019 Comcast. All rights reserved.
//

import Foundation
import UIKit

public enum AlertMessagessControllerStyle: Int {
    
    case alert
}

public class AlertMessageViewController:UIViewController{
    
    // Properties for alert title,title color and title font
    public var alertTitle: String?
    public var alertMessage:String?
    public var attributedAlertMessage:NSAttributedString?
    public var alertType:AlertType?
    
    
    private(set) var alertView = SimpleAlertView(frame: .zero)
    
    public var alertCustomView:UIView {
        return self.alertView.alertContentView
    }
    
    var alertVisualProperties:AlertVisualProperty?
    
    public var alertActionArray = [AlertMessageActions](){
        didSet{self.alertView.alertActions = self.alertActionArray}
    }
    
    // MARK:- Initialization Methods
    
    public init(alertTitle:String?,alertMessage:String?, attributedAlertMessage:NSAttributedString? = nil, alertType:AlertType){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.attributedAlertMessage = attributedAlertMessage
        self.alertType = alertType
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK:- View controller methods
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        getAlertView()
        createAlertViewConstraints()
        configureAlertHandler()
    }
    
    // MARK:- private methods
    private func getAlertView(){
        guard let receivedAlertType = self.alertType else {return}
        
        self.alertView.translatesAutoresizingMaskIntoConstraints = false
        // Set alert view background
        self.alertView.backgroundColor = self.alertVisualProperties?.alertViewBackground
        // Set alert title color and font
        self.alertView.alertTitle.textColor = self.alertVisualProperties?.titleLabelTextColor
        self.alertView.alertTitle.font = self.alertVisualProperties?.titleLabelFont
        // Set alert message color and font
        self.alertView.alertMessage.textColor = self.alertVisualProperties?.messageLabelTextColor
        self.alertView.alertMessage.font = self.alertVisualProperties?.messageLabelFont
        // Set alert buttons
        self.alertView.alertActions = self.alertActionArray
        // Set alert title , message and alert type
        self.alertView.configureAlert(title: self.alertTitle ?? "", message: self.alertMessage ?? "", attributedMessage: self.attributedAlertMessage, alertType: receivedAlertType)
        // Add subview
        self.alertView.layer.cornerRadius = 3
        self.view.addSubview(alertView)
       
    }
    
    private func createAlertViewConstraints(){
        
        NSLayoutConstraint.activate([
            alertView.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor, constant: 150),
            alertView.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: 20),
            alertView.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -20),
            alertView.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor, constant: -150),
            alertView.widthAnchor.constraint(greaterThanOrEqualToConstant: 180.0),
            alertView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            alertView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
    }
    
    private func configureAlertHandler(){
        self.alertView.actionTappedHandler = { [weak self] action in
            self?.dismiss(animated: false) {
                action.handler?(action)
            }
        }
    }

}
