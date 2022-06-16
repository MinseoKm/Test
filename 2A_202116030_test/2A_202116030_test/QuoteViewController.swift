//
//  ViewController.swift
//  2A_202116030_test
//
//  Created by 203a10 on 2022/06/16.
//


import UIKit

class QuoteViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    let quotes = [
        Quote(contents:"죽음을 두려워하는 나머지 삶을 시작조차 못하는 사람이 많다.", name:"벤다이크"),
    
        Quote(contents:"나는 나 자신을 빼 놓고는 모두 안다.", name:"이용"),
        
        Quote(contents:"편견이란 실효성이 없는 의견이다.", name:"임브로스 빌"),
        
        Quote(contents:"죽음을 두려워하는 나머지 삶을", name:"이크"),
        
        Quote(contents:"시작조차 못하는 사람이 많다.", name:"벤다"),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tabQuoteGeneratorButton(_ sender: Any) {
        let random = Int(arc4random_uniform(5))
        let quotes_instance = quotes[random]
        self.nameLabel.text = quotes_instance.name
        self.quoteLabel.text = quotes_instance.contents
    }
    
}

