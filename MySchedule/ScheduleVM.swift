//
//  ScheduleVM.swift
//  MySchedule
//
//  Created by Jackson on 21/11/2021.
//

import SwiftUI
import Foundation
class ScheduleVM : ObservableObject{
    @Published var allSchedule : [TaskInfo]
    private let calendar = Calendar.current
    
    init(){
        allSchedule = [
//            TaskInfo(date: self.calendar.date(byAdding: .day, value: 10, to: Date()) ?? Date(), todoData: [
//                TaskInfoDate(title: "Marvel Movie Time", note: "Marvel Movie", time: Date(timeIntervalSinceNow: 3600), color: Color.red),
//                TaskInfoDate(title: "Student Time", note: "Major Course", time: Date(timeIntervalSinceNow: 3800), color: Color.blue),
//                TaskInfoDate(title: "Reading Book", note: "Reading some book", time: Date(timeIntervalSinceNow: 5000), color: Color.orange),
//                TaskInfoDate(title: "Marvel Movie Time", note: "Marvel Movie", time: Date(timeIntervalSinceNow: 6000), color: Color.red)
//            ]),
//        
//            TaskInfo(date: self.calendar.date(byAdding: .day, value: -30, to: Date()) ?? Date(), todoData: [
//                TaskInfoDate(title: "Shopping", note: "Marvel Movie", time: Date(timeIntervalSinceNow: 3600), color: Color.red),
//                TaskInfoDate(title: "Tea time", note: "In Startbuck", time: Date(timeIntervalSinceNow: 3800), color: Color.red)
//            ]),
//        
//            TaskInfo(date: self.calendar.date(byAdding: .day, value: 1, to: Date()) ?? Date(), todoData: [
//                TaskInfoDate(title: "Relax Time", note: "Marvel Movie", time: Date(timeIntervalSinceNow: 3600), color: Color.red),
//                TaskInfoDate(title: "Student Time", note: "In Startbuck", time: Date(timeIntervalSinceNow: 3800), color: Color.red),
//                TaskInfoDate(title: "Reading Book", note: "In Startbuck", time: Date(timeIntervalSinceNow: 3800), color: Color.red)
//        
//            ]),
//        
//            TaskInfo(date: self.calendar.date(byAdding: .day, value: 5, to: Date()) ?? Date(), todoData: [
//                TaskInfoDate(title: "Marvel Movie Time", note: "Marvel Movie", time: Date(timeIntervalSinceNow: 3600), color: Color.red),
//                TaskInfoDate(title: "Tea time", note: "In Startbuck", time: Date(timeIntervalSinceNow: 3800), color: Color.red),
//                TaskInfoDate(title: "Reading Book", note: "In Startbuck", time: Date(timeIntervalSinceNow: 3800), color: Color.red)
//            ]),
//        
//            TaskInfo(date: self.calendar.date(byAdding: .day, value: 0, to: Date()) ?? Date(), todoData: [
//                TaskInfoDate(title: "Marvel Movie Time", note: "Marvel Movie", time: Date(timeIntervalSinceNow: 3600), color: Color.red),
//                TaskInfoDate(title: "Tea time", note: "In Startbuck", time: Date(timeIntervalSinceNow: 3800), color: Color.red),
//                TaskInfoDate(title: "Reading Book", note: "In Startbuck", time: Date(timeIntervalSinceNow: 3800), color: Color.red)
//            ])
        ]

    }
    
    func getDateFormat(date :Date) -> [String]{
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "EEEE MMMM d YYYY HH:mm" //[WeekDay Month day year time]
        return timeFormat.string(from: date).components(separatedBy: " ")
    }
    
    func findDate(date : Date) -> Int{
        
        let task = self.allSchedule.contains(where: {task in
            return self.calendar.isDate(task.date, inSameDayAs: date)
        })
        
        if task {
            return self.allSchedule.firstIndex(where: {task in
                return self.calendar.isDate(task.date, inSameDayAs: date)
            })!
        }
        
        //Not exist
        return -1
    }
    

    
}
