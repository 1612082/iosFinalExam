//
//  DetailsView.swift
//  1612082_cuoiKy
//
//  Created by LV on 1/9/19.
//  Copyright © 2019 DangNH. All rights reserved.
//

import UIKit
import Firebase

class DetailsView: UIViewController {

    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var jobDetailView: UILabel!
    @IBOutlet weak var typeDetailView: UILabel!
    @IBOutlet weak var deadlineDetail: UILabel!
    @IBOutlet weak var payDetailView: UILabel!
    @IBOutlet weak var desDetailView: UILabel!
    @IBOutlet weak var txtNameUser: UIButton!
    var apply:Bool = false
    var threadDet: Thread?
    var tempCurrUser : String?
    var userSearch:[UserModel] = []
    var nickname: String?
    //email cua thang dang xai
    var readEmail : String?
    var ref:DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        //threadDet = Thread()
        
         self.ref = Database.database().reference()
        jobDetailView.text = threadDet?.name
        typeDetailView.text = threadDet?.type
        deadlineDetail.text = threadDet?.deadline
        payDetailView.text = "\((threadDet?.payment!)!)"
        desDetailView.text = threadDet?.description
        txtNameUser.setTitle(nickname, for: .normal)
        if apply == true {
            btnApply.isHidden = false
        }
        else{
            
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func didSelectUser(_ sender: UIButton) {
        
        let personadd : PersonAddNews = storyboard?.instantiateViewController(withIdentifier: "PersonAddNews")
            as! PersonAddNews
        
        personadd.userSearch = [UserModel]()
        personadd.userSearch = userSearch
        personadd.tempCurrUser = threadDet?.emailSource
        self.navigationController?.pushViewController(personadd, animated: true)
    }
    
    @IBAction func didApply(_ sender: UIButton) {
        var moneyResult:String?
        var flag:Bool = true
        let alert : UIAlertController = UIAlertController(title: "Announcement", message: "Ban vui long nhap so tien ung tuyen", preferredStyle: .alert)
        let alert1 :UIAlertController = UIAlertController(title: "Thong bao", message: "Ban khong the apply bai chinh minh da dang", preferredStyle: .alert)
        alert.addTextField { (txtMoney) in
            txtMoney.placeholder = "Money: "
            txtMoney.keyboardType = .numberPad
            
        }
        let btnOK1:UIAlertAction = UIAlertAction(title: "OK", style: .destructive) { (btnOK) in
            
        }
        
        var IDSource:String?
        let btnOK:UIAlertAction = UIAlertAction(title: "Aplly", style: .destructive) { (btnOK) in
            let money:UITextField = alert.textFields![0] as UITextField
            if money.text == ""
            {
                
            }else{
                moneyResult = money.text!
                print(moneyResult)
                //self.writeFB(money: s)
                //present(alert1, animated: true, completion: nil)

                
            }
            if(flag ==  true){
               

                
                
                print(self.readEmail)
                let userID = Auth.auth().currentUser!.uid
                print(userID)
                self.ref?.child("\(IDSource!)/Threads/\((self.threadDet?.idThread!)!)/listApplicants/\(userID)/name").setValue(self.readEmail!)
                self.ref?.child("\(IDSource!)/Threads/\((self.threadDet?.idThread!)!)/listApplicants/\(userID)/Money").setValue(money.text)
            }
        }
        alert.addAction(btnOK)
        alert1.addAction(btnOK1)
        if self.readEmail == self.threadDet?.emailSource {
            flag = false
        }
        else{
            for item in self.userSearch
            {
                if(item.email != self.readEmail)
                {
                    if (self.threadDet?.emailSource == item.email){
                        flag = true
                        IDSource = item.IDSource
                    }
                }
            }

        }
        /*for item in self.userSearch
        {
            if(item.email == self.readEmail)
            {
                flag = false
            }
            else
            {
                if (self.threadDet?.emailSource == item.email){
                    flag = true
                    IDSource = item.IDSource
                }
            }
        }*/
        if flag == false{
            present(alert1, animated: true, completion: nil)
        }else{
            print("ccc")
            present(alert, animated: true, completion: nil)
            
            
        }
        
        
     
        
       
        
        }

   /* func writeFB(money:String)  {
        ref = Database.database().reference()
        ref?.observe(.childAdded){ (snapshot1: DataSnapshot) in
            self.ref?.child("\(snapshot1.key)/Email").observeSingleEvent(of: .value, with:
                { (snapshot2) in
                    var value = snapshot2.value as? String
                    let emailFind = value as? String
                    if (emailFind == self.readEmail){
                        print("Ban khong the apply bai ban dang");
                        
                    }else {
                        print(self.threadDet?.emailSource)
                        if (self.threadDet?.emailSource == emailFind){
                            let userID = Auth.auth().currentUser!.uid
                            self.ref?.child("\(snapshot1.key)/Threads/\((self.threadDet?.idThread!)!)/listApplicants/\(userID)/name").setValue(self.readEmail!)
                            self.ref?.child("\(snapshot1.key)/Threads/\((self.threadDet?.idThread!)!)/listApplicants/\(userID)/Money").setValue(money)
                        }
                    }
                    
            })
        }
        */
}




