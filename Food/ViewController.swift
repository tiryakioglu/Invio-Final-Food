//
//  ViewController.swift
//  Food
//
//  Created by Ali Tiryakioğlu on 30.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
   

    override func viewDidLoad() {
        setGradientBackground()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

