//
//  AddNewsController.swift
//  1612082_cuoiKy
//
//  Created by LV on 12/13/18.
//  Copyright © 2018 DangNH. All rights reserved.
//

import UIKit
import Firebase

class AddNewsController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    var ref:DatabaseReference?
    let datePicker = UIDatePicker()
    var handle:DatabaseHandle?
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return type.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return type[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectType = type[row]
        TypeTxt.text = selectType
    }
    @IBOutlet weak var jobName: UITextField!
    @IBOutlet weak var TypeTxt: UITextField!
    @IBOutlet weak var deadlineTxt: UITextField!
    @IBOutlet weak var paymentTxt: UITextField!
    @IBOutlet weak var descriptTxt: UITextField!
    
    var selectType:String?
    var readEmail: String?
    let type = ["Translating", "Transporting", "Domestic chores", "Tutoring", "Renovating", "Editing", "Housekeeping", "Babysitting", "Other"]
    
    func createType(){
        let typePicker = UIPickerView()
        typePicker.delegate = self
        TypeTxt.inputView = typePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        toolbar.setItems([doneButton], animated: true)
        TypeTxt.inputAccessoryView = toolbar
    }
    
    func createDataPicker(){
        
        datePicker.datePickerMode = .date
        deadlineTxt.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        toolbar.setItems([doneButton], animated: true)
        deadlineTxt.inputAccessoryView = toolbar
    }
    
    @objc func doneClicked() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        deadlineTxt.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createType()
        createDataPicker()
        ref = Database.database().reference()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "4")!)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButtonBar(_ sender: UIBarButtonItem) {
        let userID = Auth.auth().currentUser!.uid
        var temp: Int = 0
        ref!.child("\(userID)/Email").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? String
            self.readEmail = value!
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        self.ref?.child("\(userID)/SoLuong").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? String
          //  let username = value?["username"] as? String ?? ""
          //  let user = User(username: username)
            print("value : \(value!)")
            temp = Int(value!)!
            print(temp)
            temp = temp + 1
            self.ref?.child("\(userID)/SoLuong").setValue("\(temp)")
            self.ref?.child("\(userID)/Threads/\(temp)/Job").setValue(self.jobName.text)
            self.ref?.child("\(userID)/Threads/\(temp)/Type").setValue(self.TypeTxt.text)
            self.ref?.child("\(userID)/Threads/\(temp)/Deadline").setValue(self.deadlineTxt.text)
            self.ref?.child("\(userID)/Threads/\(temp)/Payment").setValue(self.paymentTxt.text)
            self.ref?.child("\(userID)/Threads/\(temp)/Description").setValue(self.descriptTxt.text)
            self.ref?.child("\(userID)/Threads/\(temp)/emailSource").setValue(self.readEmail)
            self.ref?.child("\(userID)/Threads/\(temp)/idThread").setValue("\(temp)")
            self.ref?.child("\(userID)/Threads/\(temp)/theChosen").setValue("???")
            self.ref?.child("\(userID)/Threads/\(temp)/theChosen/name").setValue("???")
            self.ref?.child("\(userID)/Threads/\(temp)/theChosen/tb").setValue("false")
            self.ref?.child("\(userID)/Threads/\(temp)/theChosen/rating").setValue("0")

            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        //temp = temp + 1
        //self.ref?.child("\(userID)/SoLuong").setValue("\(temp)")
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
