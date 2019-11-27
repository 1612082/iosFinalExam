//
//  AnnouncementController.swift
//  1612082_cuoiKy
//
//  Created by LV on 1/17/19.
//  Copyright © 2019 DangNH. All rights reserved.
//

import UIKit
import  Firebase

class AnnouncementController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listAnnouce.count == 0{
            return 1
        }
        
        return listAnnouce.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AnnounceCell = tableView.dequeueReusableCell(withIdentifier: "AnnounceCell") as! AnnounceCell
        if listAnnouce.count == 0 {
            //
            cell.lblJob.text = "nil"
            cell.lblType.text = "nil"
            cell.lblPay.text = "nil"
        }
        else{
            cell.lblJob.text = listAnnouce[indexPath.row].name
            cell.lblType.text = listAnnouce[indexPath.row].type
            cell.lblPay.text = "\(listAnnouce[indexPath.row].payment!)"
        }
        //cell.textLabel?.text = "không có thông báo"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if listAnnouce.count == 0 {
        }
        else{
            let detailsScreen : DetailsView = storyboard?.instantiateViewController(withIdentifier: "DetailsView")
                as! DetailsView
            detailsScreen.userSearch = [UserModel]()
            detailsScreen.userSearch = userSearch
            detailsScreen.tempCurrUser = currentUserEmail
            detailsScreen.threadDet = Thread()
            detailsScreen.threadDet?.name = listAnnouce[indexPath.row].name
            detailsScreen.threadDet?.type = listAnnouce[indexPath.row].type
            detailsScreen.threadDet?.deadline = listAnnouce[indexPath.row].deadline
            detailsScreen.threadDet?.payment = listAnnouce[indexPath.row].payment
            detailsScreen.threadDet?.description = listAnnouce[indexPath.row].description
            detailsScreen.threadDet?.emailSource = listAnnouce[indexPath.row].emailSource
            detailsScreen.threadDet?.idThread = listAnnouce[indexPath.row].idThread
            detailsScreen.readEmail = currentUserEmail
            detailsScreen.apply = true
            for index in userSearch{
                if (index.email == listAnnouce[indexPath.row].emailSource ) {
                    detailsScreen.nickname = index.nickName
                }
            }
            self.navigationController?.pushViewController(detailsScreen, animated: true)
        }
    }
    
    @IBOutlet weak var tblAnnounce: UITableView!
    var userSearch:[UserModel] = []
    var listAnnouce:[Thread] = []
    var ref:DatabaseReference!
    var currentUserEmail: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        FindListAnnounce()
        print(listAnnouce.count)
        tblAnnounce.dataSource = self
        tblAnnounce.delegate = self
        // Do any additional setup after loading the view.
    }
    func FindListAnnounce()  {
        for item in userSearch {
            var temp:Thread = Thread()
            for index in item.threads{
                temp = index
                if currentUserEmail == index.theChosen?.name {
                    listAnnouce.append(temp)
                }
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
