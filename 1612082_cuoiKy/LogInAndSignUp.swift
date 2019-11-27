//
//  ViewController.swift
//  1612082_cuoiKy
//
//  Created by DangNH on 11/10/18.
//  Copyright © 2018 DangNH. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInAndSignUp: UIViewController {
    
    @IBOutlet weak var LogIn: UIButton!
    @IBOutlet weak var SignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogIn.layer.borderWidth = 1
        LogIn.layer.borderColor = UIColor.white.cgColor
        LogIn.layer.cornerRadius = LogIn.frame.height/2
        LogIn.setTitleColor(UIColor.white, for: .normal)
        
        SignUp.layer.borderWidth = 1
        SignUp.layer.borderColor = UIColor.white.cgColor
        SignUp.layer.cornerRadius = SignUp.frame.height/2
        SignUp.setTitleColor(UIColor.white, for: .normal)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}

