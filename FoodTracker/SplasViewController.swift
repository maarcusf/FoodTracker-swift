//
//  SplasViewController.swift
//  FoodTracker
//
//  Created by Marcus Ferreira on 02/05/17.
//  Copyright © 2017 Vladyslav Chornobai. All rights reserved.
//

import Foundation
import UIKit

class SplasViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupButton.layer.cornerRadius = 5
        loginButton.layer.cornerRadius = 5
        
    }
    
    @IBAction func SignUpButton(_ sender: Any) {
        let alert = UIAlertController(title: "Ops!", message: "Método de cadastro ainda em desenvolvimento.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
       override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
}

