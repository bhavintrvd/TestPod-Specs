//
//  AlertMessageView.swift
//  techNuclues-iOS-Swift
//
//  Created by Kishor Kathar on 1/3/19.
//  Copyright © 2019 Comcast. All rights reserved.
//

import Foundation
import UIKit

//colors and fonts are dependency

public enum AlertType:String, Codable{
    //Alert Types from API
    case none         = "none"
    case info         = "info"
    case success      = "success"
    case error        = "error"
    case warning      = "warning"
    case retry        = "retry"
    case cancel       = "cancel"
    case callDOJ      = "callDOJ"
    case phoneAlert   = "phoneAlert"
    case holdUp       = "holdup"
    case errorAlertWithDetails = "errorAlertWithDetails"
    case siren        = "siren"
    case enroute      = "enroute"
    
    //Custom App Alert Type
    case fish         = "fish"

    
    var image:UIImage{
        switch self {
            case .none: return UIImage(named: "ic_info_Alert")!
            case .info, .retry: return UIImage(named: "ic_info_Alert")!
            case .success: return UIImage(named: "ic_success_Alert")!
            case .warning: return UIImage(named: "ic_warning_Alert")!
            case .error,.errorAlertWithDetails, .cancel: return UIImage(named: "ic_Error_Alert")!
            case .phoneAlert, .callDOJ: return UIImage(named: "ic_call_Alert")!
            case .holdUp: return UIImage(named: "ic_holdup_Alert")!
            case .fish: return UIImage(named: "ic_fish_Alert")!
            case .siren: return UIImage(named: "ic_siren_alert")!
            case .enroute: return UIImage(named: "ic_enroute_blue")!
        }
    }
    
    var actionBackground: UIColor{
        switch self {
        case .success:
            return .green//Constants.Color.green.color()
            
        case .error, .errorAlertWithDetails, .siren:
            return .red//Constants.Color.red.color()
            
        case .none, .info, .enroute:
            return .blue//Constants.Color.tealBlue.color()
            
        default:
            return .blue//Constants.Color.tealBlue.color()
        }
    }
    
    var titleTextColor: UIColor {
        switch self {
        case .none, .info, .success, .error, .errorAlertWithDetails:
            return .white
            
        default:
            return .white
        }
    }
    
    var titleTextFont: UIFont {
        switch self {
        case .success, .error, .errorAlertWithDetails:
            return UIFont.systemFont(ofSize: 16.0)//Constants.Font.xfinitySansMed.getUIFontForSize(16.0)
            
        default:
            return UIFont.systemFont(ofSize: 16.0)//Constants.Font.xfinitySansMed.getUIFontForSize(16.0)
        }
    }
}


class SimpleAlertView: UIView {
    
    private(set)var receivedAlertType:AlertType?
    
    var alertActions: [AlertMessageActions] = []
    var alertContentView: UIView! = UIView()
    var actionButtonLayout = AlertActionLayout.auto
    var actionsCollectionView: AlertActionView! = AlertActionView()
    var alertImageView:UIImageView! = UIImageView()
    var alertVisualProperty: AlertVisualProperty = AlertVisualProperty(alertStyle: .alert)
    var actionTappedHandler:((AlertMessageActions) -> Void)? {
        get{return self.actionsCollectionView.actionTapped}
        set{return self.actionsCollectionView.actionTapped = newValue}
    }
    
    private let scrollView = UIScrollView()
    var topView: UIView {
        return self.scrollView
    }
    
    private var elements: [UIView] {
        let possibleElements: [UIView?] = [
            self.alertImageView,
            self.alertTitle,
            self.alertMessage,
            self.alertContentView.subviews.count > 0 ? self.alertContentView : nil,
            ]
        
        #if swift(>=4.1)
        return possibleElements.compactMap { $0 }
        #else
        return possibleElements.flatMap { $0 }
        #endif
    }
    private var contentHeight: CGFloat {
        guard let lastElement = self.elements.last else {
            return 0
        }
        
        lastElement.layoutIfNeeded()
        return lastElement.frame.maxY
    }
    
    // label for main alert message
    let alertTitle:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        label.clipsToBounds = true
        return label
    }()
    // label for main alert message
    let alertMessage : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        label.clipsToBounds = true
        return label
    }()
    
    // change
    private let contentViewForScrollView : UIView = {
        let contentView = UIView(frame:.zero)
        return contentView
    }()
    //
    public func configureAttributedAlert(title:String,attributedMessage:NSAttributedString,alertType:AlertType){
      
        self.alertTitle.text = title
        self.alertMessage.attributedText = attributedMessage
        self.receivedAlertType = alertType
        setupView()
    }
    public func configureAlert(title:String,message:String, attributedMessage:NSAttributedString? = nil, alertType:AlertType){
        self.alertTitle.text = title
        
        if (attributedMessage != nil) {
            self.alertMessage.attributedText = attributedMessage
        }else{
            self.alertMessage.text = message
        }
        
        self.receivedAlertType = alertType
        setupView()
    }
    private func setupView(){
        self.actionsCollectionView.actionArray = self.alertActions
        self.actionsCollectionView.alertProperty = AlertVisualProperty(alertStyle: .alert)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.alertImageView.image = self.receivedAlertType?.image
        addSubview(self.scrollView)
        // change
        self.scrollView.addSubview(self.contentViewForScrollView)
        //
        updateCollectionViewScrollDirection()
        createUI()
        setupLayoutConstraints()
        
    }
    private func updateCollectionViewScrollDirection() {
        let layout = self.actionsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        
        if self.actionButtonLayout == .horizontal || (self.alertActions.count == 2 && self.actionButtonLayout == .auto) {
            layout?.scrollDirection = .horizontal
        } else {
            layout?.scrollDirection = .vertical
        }
    }
    private func createUI() {
        self.contentViewForScrollView.translatesAutoresizingMaskIntoConstraints = false
        // change
        for element in self.elements {
            element.translatesAutoresizingMaskIntoConstraints = false
            self.contentViewForScrollView.addSubview(element)
        }
        
        self.actionsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.actionsCollectionView)
        
        
    }
    
    private func setupLayoutConstraints(){
        //Content subviews
        createAlertImageViewConstraints()
        createAlertTitleConstraints()
        createAlertMessageConstraints()
        createAlertContentViewConstraints()
        
        //Scroll view content container
        createContentViewForScrollViewConstraints()
        
        //Scroll view
        createScrollViewConstraints()
        
        //Button collection
        createAlertCollectionViewConstraints()
    }
    
    private func createContentViewForScrollViewConstraints(){
        NSLayoutConstraint.activate([
            self.contentViewForScrollView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 1),
            self.contentViewForScrollView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 1),
            self.contentViewForScrollView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: 1),
            self.contentViewForScrollView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 1),
            self.contentViewForScrollView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            ])
        // This is to avoid conflicts between height constrains (scrollView.bottomAnchor and self.heightAnchor)
        let heightConstraint = self.contentViewForScrollView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
    }
    
    private func createAlertImageViewConstraints(){
        
        NSLayoutConstraint.activate([
            self.alertImageView.topAnchor.constraint(equalTo: self.contentViewForScrollView.topAnchor, constant: self.alertVisualProperty.imageVerticalSpacing),
            self.alertImageView.centerXAnchor.constraint(equalTo: self.contentViewForScrollView.centerXAnchor, constant: 0),
            self.alertImageView.widthAnchor.constraint(equalToConstant: 40),
            self.alertImageView.heightAnchor.constraint(equalToConstant: 40)
            ])
        self.pinToBottomOfScrollView(to: self.alertImageView, withPriority: .defaultLow)
    }
    private func createAlertTitleConstraints(){
        let contentPadding = self.alertVisualProperty.contentPadding
        
        NSLayoutConstraint.activate([
            self.alertTitle.topAnchor.constraint(equalTo: self.alertImageView.bottomAnchor, constant:self.alertVisualProperty.titleVerticalSpacing),
            self.alertTitle.leftAnchor.constraint(equalTo: self.contentViewForScrollView.leftAnchor, constant: contentPadding.left),
            self.alertTitle.rightAnchor.constraint(equalTo: self.contentViewForScrollView.rightAnchor, constant: -contentPadding.right),
            self.alertTitle.heightAnchor.constraint(equalToConstant:self.alertTitle.intrinsicContentSize.height)
            ])
        self.pinToBottomOfScrollView(to: self.alertTitle, withPriority: .defaultLow + 1.0)
    }
    private func createAlertMessageConstraints(){
        
        NSLayoutConstraint.activate([
            self.alertMessage.topAnchor.constraint(equalTo: self.alertTitle.bottomAnchor, constant:self.alertVisualProperty.messageVerticalSpacing),
            self.alertMessage.widthAnchor.constraint(equalToConstant: self.alertVisualProperty.messageWidth),
            self.alertMessage.leftAnchor.constraint(equalTo: self.contentViewForScrollView.leftAnchor, constant: self.alertVisualProperty.leadingTrailingMessageSpacing),
            self.alertMessage.rightAnchor.constraint(equalTo: self.contentViewForScrollView.rightAnchor, constant: -self.alertVisualProperty.leadingTrailingMessageSpacing),
            self.alertMessage.heightAnchor.constraint(greaterThanOrEqualToConstant: self.alertMessage.intrinsicContentSize.height)
            ])
        self.pinToBottomOfScrollView(to: self.alertMessage, withPriority: .defaultLow + 2.0)
    }
    private func createAlertContentViewConstraints(){
        if !self.elements.contains(self.alertContentView){return}
        let widthOffset = self.alertVisualProperty.contentPadding.left + self.alertVisualProperty.contentPadding.right
        NSLayoutConstraint.activate([
            self.alertContentView.topAnchor.constraint(equalTo:self.alertMessage.lastBaselineAnchor,
                                                       constant: self.alertVisualProperty.verticalSpacing),
            self.alertContentView.centerXAnchor.constraint(equalTo:self.contentViewForScrollView.centerXAnchor),
            self.alertContentView.widthAnchor.constraint(equalTo: self.contentViewForScrollView.widthAnchor, constant: -widthOffset),
            self.alertContentView.bottomAnchor.constraint(equalTo: self.contentViewForScrollView.bottomAnchor, constant: -self.alertVisualProperty.verticalSpacing),
            ])
        self.pinToBottomOfScrollView(to: self.alertMessage, withPriority: .defaultLow + 3.0)
    }
    private func createAlertCollectionViewConstraints(){
        let actionHeight = self.actionsCollectionView.heightForDisplay
        let heightConstraint = self.actionsCollectionView.heightAnchor.constraint(equalToConstant: actionHeight)
        heightConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            heightConstraint,
            self.actionsCollectionView.topAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.actionsCollectionView.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.actionsCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.actionsCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
    }
    private func createScrollViewConstraints(){
        
        NSLayoutConstraint.activate([
            self.scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.actionsCollectionView.topAnchor)
            ])
        self.scrollView.layoutIfNeeded()
        
    }
    
    private func pinToBottomOfScrollView(to view: UIView, withPriority priority: UILayoutPriority) {
        let bottomOfScrollView = view.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        bottomOfScrollView.constant = -self.alertVisualProperty.scrollViewBottomSpacing
        bottomOfScrollView.priority = priority
        bottomOfScrollView.isActive = true
    }
    
}
private extension UILayoutPriority {
    static func + (lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
        return UILayoutPriority(rawValue: lhs.rawValue + rhs)
    }
}


