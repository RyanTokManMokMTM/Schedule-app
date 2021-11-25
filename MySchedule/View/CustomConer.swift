//
//  CustomConer.swift
//  MySchedule
//
//  Created by Jackson on 17/11/2021.
//

import SwiftUI

struct CustomConer : Shape{
    var width : CGFloat = 30
    var height : CGFloat = 30
    var coners : UIRectCorner
    
    func path(in rect : CGRect) -> Path{
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: coners,cornerRadii: CGSize(width: width, height: height))
        return Path(path.cgPath)
    }
}
