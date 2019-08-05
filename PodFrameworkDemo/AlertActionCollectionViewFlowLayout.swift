//
//  AlertActionCollectionViewFlowLayout.swift
//  techNuclues-iOS-Swift
//
//  Created by Kishor Kathar on 1/9/19.
//  Copyright © 2019 Comcast. All rights reserved.
//

enum separator:String{
    case horizontal
    case verticle
}

import Foundation
import UIKit
class AlertActionCollectionViewFlowLayout:UICollectionViewFlowLayout{
    
    override init() {
        super.init()
        self.minimumInteritemSpacing = 2
        self.minimumLineSpacing = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
    }
}
