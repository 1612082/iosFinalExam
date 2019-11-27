//
//  AcceptAplly.swift
//  1612082_cuoiKy
//
//  Created by LV on 1/16/19.
//  Copyright © 2019 DangNH. All rights reserved.
//

import UIKit
import Firebase


class AcceptAplly: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var userSearch:[UserModel] = []
    var temmcurent:String?
 
    @IBOutlet weak var lblPay: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblJobName: UILabel!
    var ref:DatabaseReference?
    var postedThreads: [Thread] = []
    var ChosenName:String?
    var id:String?
    var totalThread : Thread?
    var a,b,c:String?

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ratingBtnOutlet: UIButton!
    
    @IBOutlet weak var ratingView: CosmosView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if totalThread!.listApplicants.count == 0{
            return 1
        }
        return totalThread!.listApplicants.count
        //return 1
    }
    
    @IBAction func ratingBtnClicked(_ sender: UIButton) {
        if ratingBtnOutlet.titleLabel?.text! == "RATING"{
            
            ratingView.isHidden = false

            ratingView.settings.totalStars = 5
            ratingView.settings.starSize = 40
            ratingView.settings.fillMode = .full
            ratingView.settings.starMargin = 3.3
            ratingView.settings.textColor = .red
            ratingBtnOutlet.setTitle("OK", for: .normal)
        }
        else{
            var a = ratingView!.rating as Double
            let b:Int = Int(a)
            print(b)
            ratingView.isHidden = true
            ratingBtnOutlet.setTitle("RATING", for: .normal)
            let userID = Auth.auth().currentUser!.uid
            print((totalThread?.idThread!)!)
            let id:String = (totalThread?.idThread!)!
            print(id)
            self.ref?.child("\(userID)/Threads/\(id)/theChosen/rating").setValue("\(b)")

        }
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
       // let userID = Auth.auth().currentUser!.uid
        
      //  self.ref?.child("\(userID)/Threads/\(id!)/theChosen/rating").setValue("0")
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if totalThread!.listApplicants.count == 0{
            cell?.textLabel?.text = "khong co ai applly"
        }
        else{
            cell?.textLabel?.text = totalThread?.listApplicants[indexPath.row].name as! String
        }
      //cell?.textLabel?.text = "khong co ai applly"
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if totalThread!.listApplicants.count == 0{
            
        }
        else{
        let applier : InfoApplierController = (storyboard?.instantiateViewController(withIdentifier: "InfoApplierController") as? InfoApplierController)!
        
        applier.userSearch = [UserModel]()
        applier.userSearch = userSearch
        applier.tempCurrUser = totalThread?.listApplicants[indexPath.row].name as! String
        applier.email = totalThread?.emailSource as? String
        applier.id = totalThread?.idThread as? String
        
            self.navigationController?.pushViewController(applier, animated: true)
            
        }
    }
    



    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //ratingBtnOutlet.isHidden = true
        //name cua nguoi duoc chon
        FindNick()
        readPostedThreads()
        //print(totalThread?.listApplicants)
        ref = Database.database().reference()
        lblJobName.text = totalThread?.name
        lblType.text = totalThread?.type
        lblPay.text = "\((totalThread?.payment!)!) VND"
        nameLbl.text = totalThread?.theChosen?.name

        tblView.dataSource = self
        tblView.delegate = self
        // Do any additional setup after loading the view.
    }
    func readPostedThreads(){
        
        for index in userSearch{
            
            if ((index.email)! == (temmcurent)! ) {
                
                for index2 in index.threads{
                    postedThreads.append(index2)
                   
                    print(index2.name)
                }
            }
        }
        //print(postedThreads[1].name)
    }
    func FindNick()
    {
        for item in userSearch{
            if item.email == temmcurent{
                a = item.nickName
                b = item.email
                c = item.phone
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
