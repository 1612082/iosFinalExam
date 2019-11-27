//
//  ProfileViewController.swift
//  1612082_cuoiKy
//
//  Created by LV on 1/9/19.
//  Copyright © 2019 DangNH. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblNickName: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lblPhone: UILabel!
    var a,b,c:String?
    var tempCurrUser : String?
    var userSearch:[UserModel] = []
    @IBOutlet weak var threadTbl: UITableView!
    @IBOutlet weak var applyTbl: UITableView!
    //var totalThread : [Thread] = []
    var postedThreads: [Thread] = []
    var appliedThreads: [Thread] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?

        
        if tableView == self.threadTbl{
            count = postedThreads.count
        }
        if tableView == self.applyTbl{
            count = appliedThreads.count
        }
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellToReturn:UITableViewCell?
        if tableView == self.threadTbl {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThreadViewCell") as! ThreadViewCell
            cell.txtJobName.text = postedThreads[indexPath.row].name
            cell.txtTypeJob.text = postedThreads[indexPath.row].type
            cell.txtPayment.text = "\(postedThreads[indexPath.row].payment!)"
            cellToReturn = cell
        }
        if tableView == self.applyTbl {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ApplyViewCell") as! ApplyViewCell
            cell.txtJobName.text = appliedThreads[indexPath.row].name
            cell.txtTypeJob.text = appliedThreads[indexPath.row].type
            cell.txtPayment.text = "\(appliedThreads[indexPath.row].payment!)"
            cellToReturn = cell
        }
        return cellToReturn!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.threadTbl {
            let accept : AcceptAplly = storyboard?.instantiateViewController(withIdentifier: "AcceptAplly")
                as! AcceptAplly
            //print(postedThreads[indexPath.row].listApplicants)
            accept.totalThread = Thread()
            accept.totalThread = postedThreads[indexPath.row]
            accept.temmcurent = postedThreads[indexPath.row].emailSource
            accept.userSearch = userSearch
            
            self.navigationController?.pushViewController(accept, animated: true)
        }
        if tableView == self.applyTbl {
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
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        readPostedThreads()
        readAppliedThreads()
        FindNick()
        lblNickName.text = a
        lblEmail.text = b
        lblPhone.text = c
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        readPostedThreads()
        readAppliedThreads()
    }
// tu danh sach tong tim toi data cua user trong firebase lay tat ca cac thread trong data nay
    func readPostedThreads(){

       for index in userSearch{

            if ((index.email)! == (tempCurrUser)! ) {
                
                for index2 in index.threads{
                    postedThreads.append(index2)
                   
                    print(index2.name)
                }
            }
        }
        //print(postedThreads[1].name)
    }
    // tu tat ca cac thread trong firebase lay ra thread co user dang su dung apply
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
    func FindNick()
    {
        for item in userSearch{
            if item.email == tempCurrUser{
                a = item.nickName
                b = item.email
                c = item.phone
            }
        }
    }

}
