//
//  MenuViewController.swift
//  wordcoin3
//
//  Created by admin on 20.02.2024.
//  Copyright © 2024 admin. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var temka: UIButton!
    @IBOutlet weak var slojno: UIButton!
    @IBOutlet weak var random: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        temka.layer.cornerRadius = temka.frame.height / 6
        slojno.layer.cornerRadius = slojno.frame.height / 6
        random.layer.cornerRadius = random.frame.height / 6
    }
    
}
