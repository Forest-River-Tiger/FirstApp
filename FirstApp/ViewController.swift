//
//  ViewController.swift
//  FirstApp
//
//  Created by 森川大雅 on 2022/04/02.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func touchedButton(_ sender: Any) {
        titleLabel.text = "タッチしました"
    }
    

}

