//
//  CustomView.swift
//  Animation_Helper_API_Explained
//
//  Created by Alex Jiang on 29/03/2016.
//  Copyright © 2016 Pigfly. All rights reserved.
//

import Foundation
import UIKit

class CustomView: UIView {
    let demoView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    
    func defaultInit() {
        self.addSubview(demoView)
        
        demoView.frame = CGRectMake(0, 0, 100, 100)
        demoView.backgroundColor = UIColor.purpleColor()
        
        self.backgroundColor = UIColor.greenColor()
        
        UIView.animateWithDuration(5.0) { () -> Void in
            self.backgroundColor = UIColor.redColor()
            self.demoView.center = CGPointMake(100, 100)
        }
        puts("foo bar")
    }
    
    
}