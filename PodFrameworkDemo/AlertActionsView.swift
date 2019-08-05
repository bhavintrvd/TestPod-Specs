//
//  AlertActionsView.swift
//  techNuclues-iOS-Swift
//
//  Created by Kishor Kathar on 1/9/19.
//  Copyright © 2019 Comcast. All rights reserved.
//

import Foundation
import UIKit

private let alertActionCellIdentifier = "alertActionCell"

class AlertActionView:UICollectionView{
    
    var actionArray:[AlertMessageActions] = []
    var actionTapped: ((AlertMessageActions) -> Void)?
    
    
    var alertProperty: AlertVisualProperty = AlertVisualProperty(alertStyle: .alert)
    
    var heightForDisplay:CGFloat{
        guard let actionLayout = self.collectionViewLayout as? AlertActionCollectionViewFlowLayout else {return -1}
        
        if actionLayout.scrollDirection == .horizontal{
           return  alertProperty.actionViewSize.height
        }else{
            
           
            return alertProperty.actionViewSize.height*CGFloat(self.numberOfItems(inSection: 0))
        }
        
    }
    
    init() {
        super.init(frame: .zero, collectionViewLayout:AlertActionCollectionViewFlowLayout())
        self.dataSource = self
        self.delegate = self
        self.backgroundColor = .clear
        self.delaysContentTouches = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(AlertActionCollectionCell.self, forCellWithReuseIdentifier: alertActionCellIdentifier)
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
}

extension AlertActionView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.actionArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: alertActionCellIdentifier,
                                                      for: indexPath) as? AlertActionCollectionCell
        
        let action = self.actionArray[(indexPath as NSIndexPath).item]
        // Set alert button background color. Default color White
        cell?.backgroundColor = action.actionBackground ?? UIColor.init(red: 239.0/255, green: 239.0/255, blue: 239.0/255, alpha: 1.0)
        // Set alert button title and color
        cell?.setAction(action, property: self.alertProperty)
        
        return cell!
    }
}

extension AlertActionView : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let actionWidth = self.alertProperty.actionViewSize.width
        let actionHeight = self.alertProperty.actionViewSize.height
        
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        
        if layout.scrollDirection == .horizontal {
            let width = max(self.bounds.width / CGFloat(self.numberOfItems(inSection: 0)), actionWidth)
            return CGSize(width: width, height: actionHeight)
        } else {
            return CGSize(width: self.bounds.width, height: actionHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.actionTapped?(self.actionArray[(indexPath as NSIndexPath).item])
    }
}
