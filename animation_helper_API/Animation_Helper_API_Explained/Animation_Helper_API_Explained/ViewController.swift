//
//  ViewController.swift
//  Animation_Helper_API_Explained
//
//  Created by Alex Jiang on 29/03/2016.
//  Copyright © 2016 Pigfly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customView = CustomView(frame: self.view.frame)
        self.view.addSubview(customView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

