//
//  HomeController.swift
//  1612082_cuoiKy
//
//  Created by LV on 12/10/18.
//  Copyright © 2018 DangNH. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var handle:DatabaseHandle?
    var ref:DatabaseReference!
    var tempThread: [Thread] = []
    var searchList: [Thread] = []
    var UsersList: [UserModel] = []
    var listUserEmail: [String] = []
    var currentUserEmail: String?
    var Curr : String = "datnt"
    //var vc = SignInController()
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var ratingStar: CosmosView!
    @IBOutlet weak var tblView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return tempThread.count
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        //ratingStar.
        /*
         print(cell.ratingStar.rating)
         cell.jobnameTxt.text =  tempThread[indexPath.row].name
         cell.typeTxt.text = tempThread[indexPath.row].type
         cell.deadlineTxt.text = tempThread[indexPath.row].deadline
         cell.paymentTxt.text = "\(tempThread[indexPath.row].payment!)"
         cell.readEmailThread = tempThread[indexPath.row].emailSource
         cell.readIdThread = tempThread[indexPath.row].idThread
         cell.readEmailUser = self.currentUserEmail
         */
        cell.jobnameTxt.text =  searchList[indexPath.row].name
        cell.typeTxt.text = searchList[indexPath.row].type
        cell.deadlineTxt.text = searchList[indexPath.row].deadline
        cell.paymentTxt.text = "\(searchList[indexPath.row].payment!)"
        cell.readEmailThread = searchList[indexPath.row].emailSource
        cell.readIdThread = searchList[indexPath.row].idThread
        cell.readEmailUser = self.currentUserEmail
        switch searchList[indexPath.row].type {
        case "Translating":
            cell.iconJob.image = UIImage(named: "translate")
        case "Domestic chores":
            cell.iconJob.image = UIImage(named: "household")
        case "Editing":
            cell.iconJob.image = UIImage(named: "edit")
        case "Tutoring":
            cell.iconJob.image = UIImage(named: "tutor")
        case "Renovating":
            cell.iconJob.image = UIImage(named: "renovate")
        case "Housekeeping":
            cell.iconJob.image = UIImage(named: "house")
        case "Babysitting":
            cell.iconJob.image = UIImage(named: "babysit")
        case "Transporting":
            cell.iconJob.image = UIImage(named: "transport")
        case "Other":
            cell.iconJob.image = UIImage(named: "others")
        default:
            break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsScreen : DetailsView = storyboard?.instantiateViewController(withIdentifier: "DetailsView")
            as! DetailsView
        detailsScreen.userSearch = [UserModel]()
        detailsScreen.userSearch = UsersList
        detailsScreen.tempCurrUser = currentUserEmail
        detailsScreen.threadDet = Thread()
        detailsScreen.threadDet?.name = searchList[indexPath.row].name
        detailsScreen.threadDet?.type = searchList[indexPath.row].type
        detailsScreen.threadDet?.deadline = searchList[indexPath.row].deadline
        detailsScreen.threadDet?.payment = searchList[indexPath.row].payment
        detailsScreen.threadDet?.description = searchList[indexPath.row].description
        detailsScreen.threadDet?.emailSource = searchList[indexPath.row].emailSource
        detailsScreen.threadDet?.idThread = searchList[indexPath.row].idThread
        detailsScreen.readEmail = currentUserEmail
        detailsScreen.apply = true
        for index in UsersList{
            if (index.email == searchList[indexPath.row].emailSource ) {
                detailsScreen.nickname = index.nickName
            }
        }
        self.navigationController?.pushViewController(detailsScreen, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    @IBOutlet var menuList: [UIButton]!
    
    @IBAction func didSelectProfile(_ sender: Any) {
        let profileScreen : ProfileViewController = storyboard?.instantiateViewController(withIdentifier: "ProfileView") as! ProfileViewController
        profileScreen.userSearch = [UserModel]()
        profileScreen.userSearch = UsersList
        profileScreen.tempCurrUser = currentUserEmail
        //profileScreen.totalThread = tempThread
        
        self.navigationController?.pushViewController(profileScreen, animated: true)
    }
    var test: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(vc.tempThread)
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        ref = Database.database().reference()
        self.readFireBase()
        
        // Do any additional setup after loading the view.
    }
    func dismissKeyboard(){
        view.endEditing(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        searchList = tempThread
        
        tblView.reloadData()
    }
    var getUser = UserModel()
    
    
    @IBAction func logOutBtn(_ sender: UIBarButtonItem) {
        try! Auth.auth().signOut()
        //self.dismiss(animated: false, completion: nil)
        
        self.performSegue(withIdentifier: "logout", sender: self)
        
    }
    
    @IBAction func MenuTapped(_ sender: UIBarButtonItem) {
        menuList.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    // MARK: - Navigation
    @IBAction func kt(_ sender: UIBarButtonItem) {
        let annouce : AnnouncementController = storyboard?.instantiateViewController(withIdentifier: "AnnouncementController") as! AnnouncementController
      /*  profileScreen.userSearch = [UserModel]()
        profileScreen.userSearch = UsersList
        profileScreen.tempCurrUser = currentUserEmail
        //profileScreen.totalThread = tempThread
        */
        annouce.userSearch = [UserModel]()
        annouce.userSearch = UsersList
        annouce.currentUserEmail = currentUserEmail
        self.navigationController?.pushViewController(annouce, animated: true)

        
    }
    func readFireBase()
    {
        let userID = Auth.auth().currentUser!.uid
        self.ref?.child("\(userID)/Email").observeSingleEvent(of: .value, with:
            { (snapshot) in
                var value = snapshot.value as? String
                self.currentUserEmail = value
        })
        
        ref?.observe(.childAdded){ (snapshot: DataSnapshot) in
            var temp1 = UserModel()
            self.ref?.child("\(snapshot.key)/Email").observeSingleEvent(of: .value, with:
                { (snapshot) in
                    var value = snapshot.value as? String
                    temp1.email = value
                    
                    
            })
            
            //them
            self.ref?.child("\(snapshot.key)/IDSource").observeSingleEvent(of: .value, with:
                { (snapshot) in
                    var value = snapshot.value as? String
                    temp1.IDSource = value
                    
                    
            })
            
            
            self.ref?.child("\(snapshot.key)/NickName").observeSingleEvent(of: .value, with:
                { (snapshot) in
                    var value = snapshot.value as? String
                    temp1.nickName = value
            })
            self.ref?.child("\(snapshot.key)/Phone").observeSingleEvent(of: .value, with: { (snapshot) in
                var value = snapshot.value as? String
                temp1.phone = value
            })
            
            self.ref?.child("\(snapshot.key)/SoLuong").observeSingleEvent(of: .value, with: { (snapshot) in
                var value = snapshot.value as? String
                temp1.numOfThreads  = Int(value!)!
                
            })
            
            self.ref?.child("\(snapshot.key)/Threads").observe(.childAdded) { (snapshot2) in
                //print(snapshot2.key)
                var temp2 = Thread()
                temp2.theChosen = Choose()
                self.ref?.child("\(snapshot.key)/Threads/\(snapshot2.key)/Type").observeSingleEvent(of: .value, with: { (snapshot3) in
                    var value = snapshot3.value as? String
                    temp2.type = value
                })
                self.ref?.child("\(snapshot.key)/Threads/\(snapshot2.key)/Deadline").observeSingleEvent(of: .value, with: { (snapshot3) in
                    var value = snapshot3.value as? String
                    // print(value)
                    temp2.deadline = value as? String
                    //  print("Date: \(temp2.deadline)")
                })
                self.ref?.child("\(snapshot.key)/Threads/\(snapshot2.key)/Job").observeSingleEvent(of: .value, with: { (snapshot3) in
                    var value = snapshot3.value as? String
                    temp2.name = value
                    
                })
                self.ref?.child("\(snapshot.key)/Threads/\(snapshot2.key)/Description").observeSingleEvent(of: .value, with: { (snapshot3) in
                    var value = snapshot3.value as? String
                    temp2.description = value
                })
                self.ref?.child("\(snapshot.key)/Threads/\(snapshot2.key)/Payment").observeSingleEvent(of: .value, with: { (snapshot3) in
                    var value = snapshot3.value as? String
                    //    print("tien:\(value)")
                    
                    var NumberFor = NumberFormatter()
                    var number = NumberFor.number(from: value ?? "0")
                    temp2.payment = number as! Float
                })
                
                self.ref?.child("\(snapshot.key)/Threads/\(snapshot2.key)/emailSource").observeSingleEvent(of: .value, with: { (snapshot3) in
                    var value = snapshot3.value as? String
                    temp2.emailSource = value as? String
                })
                
                self.ref?.child("\(snapshot.key)/Threads/\(snapshot2.key)/idThread").observeSingleEvent(of: .value, with: { (snapshot3) in
                    var value = snapshot3.value as? String
                    temp2.idThread = value as? String
                    
                })
                
                self.ref?.child("\(snapshot.key)/Threads/\(snapshot2.key)/listApplicants").observe(.childAdded) { (snapshot4) in
                    var ad: [String] = []
                    var temp3 = snapshot4.key
                    var applica:Applicant = Applicant()
                    
                    self.ref?.child("\(snapshot.key)/Threads/\(snapshot2.key)/listApplicants/\(temp3)/Money").observeSingleEvent(of: .value, with: { (snapshot) in
                        var value = snapshot.value as? String
                        applica.money = value
                        
                    })
                    self.ref?.child("\(snapshot.key)/Threads/\(snapshot2.key)/listApplicants/\(temp3)/name").observeSingleEvent(of: .value, with: { (snapshot) in
                        var value1 = snapshot.value as? String
                        applica.name = value1
                        
                    })
                    temp2.listApplicants.append(applica)
                }
                
               
                self.ref?.child("\(snapshot.key)/Threads/\(snapshot2.key)/theChosen/name").observeSingleEvent(of: .value, with: { (snapshot) in
                    var value1 = snapshot.value as? String
                    print(value1)
                    temp2.theChosen?.name = value1
                    print(temp2.theChosen?.name)
                })
                self.ref?.child("\(snapshot.key)/Threads/\(snapshot2.key)/theChosen/rating").observeSingleEvent(of: .value, with: { (snapshot) in
                    var value1 = snapshot.value as? String
                   print(value1)
                    temp2.theChosen?.rating = value1
                   print(temp2.theChosen?.rating)
                    
                })
                self.ref?.child("\(snapshot.key)/Threads/\(snapshot2.key)/theChosen/tb").observeSingleEvent(of: .value, with: { (snapshot) in
                    var value1 = snapshot.value as? String
                    print(value1)
                    temp2.theChosen?.tb = value1
                    print(temp2.theChosen?.tb)
                })
                temp1.threads.append(temp2)
                self.tempThread.append(temp2)
            }
            
            self.UsersList.append(temp1)
            
            
            //  let username = value?["username"] as? String ?? ""
            //  let user = User(username: username)
        }
    }
    
    var names: [String] = []
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList = tempThread.filter{
            $0.name!.range(of: searchText, options: .caseInsensitive) != nil}
        
        tblView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchList = tempThread
        searchBar.endEditing(true)
        tblView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        switch selectedScope{
        case 0:
            searchList = tempThread
        case 1: //translating
            searchList = tempThread.filter({$0.type == "Translating"})
        case 2: //domestic chores
            searchList = tempThread.filter({$0.type == "Domestic chores"})
        case 3: //tutoring
            searchList = tempThread.filter({$0.type == "Tutoring"})
        case 4: //renovating
            searchList = tempThread.filter({$0.type == "Renovating"})
        case 5: //editing
            searchList = tempThread.filter({$0.type == "Editing"})
        case 6: //housekeeping
            searchList = tempThread.filter({$0.type == "Housekeeping"})
        case 7: //babysitting
            searchList = tempThread.filter({$0.type == "Babysitting"})
        case 8: //transporting
            searchList = tempThread.filter({$0.type == "Transporting"})
        case 9: //other
            searchList = tempThread.filter({$0.type == "Other"})
        default:
            break
        }
        tblView.reloadData()
    }
}

