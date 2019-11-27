//
//  TableViewCell.swift
//  1612082_cuoiKy
//
//  Created by LV on 12/17/18.
//  Copyright © 2018 DangNH. All rights reserved.
//

import UIKit
import Firebase


class TableViewCell: UITableViewCell  {
    var ref:DatabaseReference?
    var readEmailThread: String?
    var readEmailUser: String?
    var readIdThread: String?
    
    @IBOutlet weak var jobnameTxt: UILabel!
    @IBOutlet weak var paymentTxt: UILabel!
    @IBOutlet weak var iconJob: UIImageView!
    @IBOutlet weak var deadlineTxt: UILabel!
    @IBOutlet weak var typeTxt: UILabel!
    @IBOutlet weak var ratingStar: CosmosView!
    override func awakeFromNib() {
        //vc.tempThread[]
        super.awakeFromNib()
        // Initialization code
    }
    
   /* @IBAction func didApply(_ sender: UIButton) {
        ref = Database.database().reference()
        ref?.observe(.childAdded){ (snapshot1: DataSnapshot) in
            self.ref?.child("\(snapshot1.key)/Email").observeSingleEvent(of: .value, with:
                { (snapshot2) in
                    
                    var value = snapshot2.value as? String
                    print(value)
                    //var currentID = snapshot.key as! String
                    
                    let emailFind = value as? String
                    print(emailFind)
                    print(self.readEmailUser)
                    if (emailFind == self.readEmailUser){
                        print("Ban khong the apply bai ban dang");
                        
                    }else {
                        if (self.readEmailThread == emailFind){
                            print(snapshot1.key)
                            print(snapshot2.key)
                            //print(currentID)
                            let userID = Auth.auth().currentUser!.uid
                            self.ref?.child("\(snapshot1.key)/Threads/\(self.readIdThread!)/listApplicants/\(userID)").setValue(self.readEmailUser!)
                        }
                    }
                    
            })
            
        }
        /*
        print("Id: \(self.readIdThread)")
        print("EmailThread: \(self.readEmailThread)")
        print("EmailUser: \(self.readEmailUser)")
        */
        
    } */
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
