//
//  TemaYrovenViewController.swift
//  wordcoin3
//
//  Created by admin on 26.02.2024.
//  Copyright © 2024 admin. All rights reserved.
//

import UIKit

class TemaYrovenViewController: UIViewController {
    
    @IBOutlet weak var first: UIButton!
    
    @IBOutlet weak var second: UIButton!
    
    @IBOutlet weak var third: UIButton!
    
    @IBOutlet weak var four: UIButton!
    
    @IBOutlet weak var five: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        first.layer.cornerRadius = first.frame.height / 2
        second.layer.cornerRadius = second.frame.height / 2
        third.layer.cornerRadius = third.frame.height / 2
        four.layer.cornerRadius = four.frame.height / 2
        five.layer.cornerRadius = five.frame.height / 2
        
        
    }
    


}
