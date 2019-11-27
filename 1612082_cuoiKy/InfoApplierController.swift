//
//  InfoApplierController.swift
//  1612082_cuoiKy
//
//  Created by LV on 1/16/19.
//  Copyright © 2019 DangNH. All rights reserved.
//

import UIKit
import Firebase

class InfoApplierController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var appliedThreads: [Thread] = []
    var tempCurrUser : String?
    var userSearch:[UserModel] = []
    //email nguoi dc chon
    var email:String?
    var id: String?
    var ref:DatabaseReference?
    
    @IBOutlet weak var nickApply: UILabel!
    @IBOutlet weak var emailAplly: UILabel!
    @IBOutlet weak var phoneApply: UILabel!
    
    @IBOutlet weak var tblView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return appliedThreads.count
        //return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApplierCell") as! ApplierCell
        cell.jobApllier.text = appliedThreads[indexPath.row].name
        cell.typeApllier.text = appliedThreads[indexPath.row].type
        cell.payApllier.text = "\(appliedThreads[indexPath.row].payment!)"
 
 
        return cell
    }
    
    @IBAction func acceptButton(_ sender: UIButton) {
        
        let userID = Auth.auth().currentUser!.uid
        
        //  self.ref?.child("\(userID)/Threads/\(id!)/theChosen/name").setValue(email)
        
      //  self.ref?.child("\(userID)/Threads/\(id!)/theChosen/name").setValue(email)
        let Home : HomeController = storyboard?.instantiateViewController(withIdentifier: "HomeController")
            as! HomeController
        self.ref?.child("\(userID)/Threads/\(id!)/theChosen/name").setValue(tempCurrUser)
        self.ref?.child("\(userID)/Threads/\(id!)/theChosen/tb").setValue("true")
        self.ref?.child("\(userID)/Threads/\(id!)/theChosen/rating").setValue("0")
       
        self.navigationController?.pushViewController(Home, animated: true)
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsScreen : DetailsView = storyboard?.instantiateViewController(withIdentifier: "DetailsView")
            as! DetailsView
        detailsScreen.userSearch = [UserModel]()
        detailsScreen.userSearch = userSearch
        detailsScreen.tempCurrUser = tempCurrUser
        detailsScreen.threadDet = Thread()
        detailsScreen.threadDet?.name = appliedThreads[indexPath.row].name
        detailsScreen.threadDet?.type = appliedThreads[indexPath.row].type
        detailsScreen.threadDet?.deadline = appliedThreads[indexPath.row].deadline
        detailsScreen.threadDet?.payment = appliedThreads[indexPath.row].payment
        detailsScreen.threadDet?.description = appliedThreads[indexPath.row].description
        detailsScreen.threadDet?.emailSource = appliedThreads[indexPath.row].emailSource
        detailsScreen.threadDet?.idThread = appliedThreads[indexPath.row].idThread
        detailsScreen.readEmail = tempCurrUser
        detailsScreen.nickname = ""
        self.navigationController?.pushViewController(detailsScreen, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readAppliedThreads()
        ref = Database.database().reference()
        emailAplly.text = tempCurrUser
        for index in userSearch {
            if ( email == index.email)
            {
                nickApply.text = index.nickName
                phoneApply.text = index.phone
            }
        }
        tblView.dataSource = self
        tblView.delegate = self
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func readAppliedThreads(){
        
        for index in userSearch{
            for index2 in index.threads{
                var temp = Thread()
                temp = index2
                for index3 in index2.listApplicants{
                    if (index3.name == tempCurrUser){
                        appliedThreads.append(temp)
                    }
                }
            }
        }
    }
}
