//
//  TaskModel.swift
//  MySchedule
//
//  Created by Jackson on 18/11/2021.
//

import SwiftUI

struct TaskInfo : Identifiable{
    var id = UUID().uuidString
    var date : Date
    var todoData : [TaskInfoDate]
}


struct TaskInfoDate : Identifiable{
    var id = UUID().uuidString
    var title : String //
    var note : String
    var time : Date
    var color : Color
    var isDone : Bool 
}
