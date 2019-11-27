//
//  File.swift
//  1612082_cuoiKy
//
//  Created by LV on 12/13/18.
//  Copyright © 2018 DangNH. All rights reserved.
//

import Foundation
class Thread
{
    
    
    var name:String?
    var type:String?
    var deadline:String?
    //var postday:Date?
    var description:String?
    var payment:Float?
    var emailSource: String?
    var idThread: String?
    var listApplicants:[Applicant]=[]
    var theChosen:Choose?
}
class UserModel {
    var nickName: String?
    var email: String?
    var numOfThreads: Int?
    var phone:String?
    var threads: [Thread] = []
    //them
    var IDSource:String?
}
class Applicant {
    var name:String?
    var money:String?
}
class Choose
{
    var name:String?
    var tb:String?
    var rating: String?
}
