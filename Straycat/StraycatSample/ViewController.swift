//
//  ViewController.swift
//  StraycatSample
//
//  Created by Harry Twan on 16/03/2018.
//  Copyright © 2018 Harry Twan. All rights reserved.
//

import UIKit
import Straycat

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        StrayTrending.shared.fe
        StrayTrending.shared.fetchRepo { success, repos in
            
        }
        
    }
}

