//
//  DateModel.swift
//  MySchedule
//
//  Created by Jackson on 17/11/2021.
//

import SwiftUI

struct DateModel : Identifiable {
    var id = UUID().uuidString
    let day : Int
    let date : Date
}
