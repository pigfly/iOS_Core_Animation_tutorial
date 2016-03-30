//
//  CustomButton.swift
//  Animation_Helper_API_Explained
//
//  Created by Alex Jiang on 30/03/2016.
//  Copyright © 2016 Pigfly. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let newPoint = self.layer.presentationLayer()!.convertPoint(point, fromLayer: layer)
        
        return super.hitTest(newPoint, withEvent: event)
    }
}