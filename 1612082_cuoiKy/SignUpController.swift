//
//  SignUpController.swift
//  1612082_cuoiKy
//
//  Created by LV on 12/10/18.
//  Copyright © 2018 DangNH. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpController: UIViewController {
    var currentEmail: String?
    var ref:DatabaseReference?
    @IBOutlet weak var userTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var phoneNumTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpBtn(_ sender: UIButton) {

        Auth.auth().createUser(withEmail: emailTxt.text!, password: passwordTxt.text!) { (user, err) in
            if user != nil && err == nil
            {
                print("User created")
                Auth.auth().signIn(withEmail: self.emailTxt.text!, password: self.passwordTxt.text!) { (user, err) in
                    if user != nil && err == nil
                    {
                        print("User logged in")
                        let userID = Auth.auth().currentUser!.uid
                        self.ref?.child("\(userID)/Email").setValue(self.emailTxt.text)
                        self.currentEmail = self.emailTxt.text
                        self.ref?.child("\(userID)/SoLuong").setValue("0")
                        self.ref?.child("\(userID)/NickName").setValue(self.userTxt.text)
                        self.ref?.child("\(userID)/Phone").setValue(self.phoneNumTxt.text)
                        self.ref?.child("\(userID)/IDSource").setValue(userID)


                        self.performSegue(withIdentifier: "loginLink", sender: self)
                        
                    } else {
                        print("Error")

                    }
                    
                    try! Auth.auth().signOut()
                    
                }
            } else {
                print("Error")

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

}
