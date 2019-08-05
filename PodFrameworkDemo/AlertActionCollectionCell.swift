//
//  AlertActionCollectionCell.swift
//  techNuclues-iOS-Swift
//
//  Created by Kishor Kathar on 1/9/19.
//  Copyright © 2019 Comcast. All rights reserved.
//

import Foundation
import UIKit

class AlertActionCollectionCell : UICollectionViewCell{
    
   private let actionTitle:UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
       super.init(frame: frame)
        setupCellContains()
    }
   
    func setupCellContains(){
     addSubview(actionTitle)
     setupCellConstraints()
    }
  
    func setupCellConstraints(){
       
        NSLayoutConstraint.activate([
            actionTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            actionTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            actionTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            actionTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
            ])
    }
    
    func setAction(_ action:AlertMessageActions, property:AlertVisualProperty){
     
        // set action view
        action.actionView = self
        // set alert button title. Default title is No Title!
        self.actionTitle.text = action.title ?? "No Title!"
        // set alert title color.Default color is Black
        self.actionTitle.textColor = action.titleTextColor ?? UIColor.black
        // set alert button font. Default is system bold font with size 16.0
        self.actionTitle.font =  action.titleTextFont ?? UIFont.boldSystemFont(ofSize: 16.0)
        
    }
    
}


