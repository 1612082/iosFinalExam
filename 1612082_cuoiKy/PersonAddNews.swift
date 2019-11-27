//
//  PersonAddNews.swift
//  1612082_cuoiKy
//
//  Created by LV on 1/16/19.
//  Copyright © 2019 DangNH. All rights reserved.
//

import UIKit
import Firebase


class PersonAddNews: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var lblNickNAme: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    var a,b,c:String?

    var postedThreads: [Thread] = []
    var userSearch:[UserModel] = []
    var tempCurrUser : String?
    @IBOutlet weak var threadTbl: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 5
        return postedThreads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThreadViewCellPersonAdd") as! ThreadViewCellPersonAdd
                cell.txtJobName.text = postedThreads[indexPath.row].name
        cell.txtTypeJob.text = postedThreads[indexPath.row].type
        cell.txtPayment.text = "\(postedThreads[indexPath.row].payment!)"
        return cell
        /*cell.txtJobName.text = "a"
        cell.txtTypeJob.text = "b"
        cell.txtPayment.text = "c"
        return cell*/
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = "dangnguyen"
        return cell!*/
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsScreen : DetailsView = storyboard?.instantiateViewController(withIdentifier: "DetailsView")
            as! DetailsView
        detailsScreen.userSearch = [UserModel]()
        detailsScreen.userSearch = userSearch
        detailsScreen.tempCurrUser = tempCurrUser
        detailsScreen.threadDet = Thread()
        detailsScreen.threadDet?.name = postedThreads[indexPath.row].name
        detailsScreen.threadDet?.type = postedThreads[indexPath.row].type
        detailsScreen.threadDet?.deadline = postedThreads[indexPath.row].deadline
        detailsScreen.threadDet?.payment = postedThreads[indexPath.row].payment
        detailsScreen.threadDet?.description = postedThreads[indexPath.row].description
        detailsScreen.threadDet?.emailSource = postedThreads[indexPath.row].emailSource
        detailsScreen.threadDet?.idThread = postedThreads[indexPath.row].idThread
        detailsScreen.readEmail = tempCurrUser
        detailsScreen.nickname = ""
        self.navigationController?.pushViewController(detailsScreen, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readPostedThreads()
        FindNick()
        lblNickNAme.text = a
        lblEmail.text = b
        lblPhone.text = c
        threadTbl.delegate = self
        threadTbl.dataSource = self
        // Do any additional setup after loading the view.
    }

    

    func readPostedThreads(){
        for index in userSearch{
            if ((index.email)! == (tempCurrUser)! ) {
                for index2 in index.threads{
                    postedThreads.append(index2)
                }
            }
        }
        print(postedThreads[1].name)
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
