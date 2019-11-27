//
//  SignInController.swift
//  1612082_cuoiKy
//
//  Created by LV on 12/10/18.
//  Copyright © 2018 DangNH. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInController: UIViewController {
    var ref:DatabaseReference!
    @IBOutlet weak var userTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func signInBtn(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: userTxt.text!, password: passTxt.text!) { (user, err) in
            if user != nil && err == nil
            {
                print("User logged in")
                

                let userID = Auth.auth().currentUser!.uid
                //self.ref?.child("\(userID)/Email").setValue(self.userTxt.text)
                
                //self.ref?.child("\(userID)/SoLuong").setValue("0")
                if let user = Auth.auth().currentUser {
                    /*let sb = UIStoryboard(name: "Main", bundle: nil)
                     let manhinh2 = sb.instantiateViewController(withIdentifier: "HomeController") as! HomeController
                     self.navigationController?.pushViewController(manhinh2, animated: true)*/
             
                    self.performSegue(withIdentifier: "logInToHome", sender: self)
                    
                }

            } else {
                print("Error")
            }
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
