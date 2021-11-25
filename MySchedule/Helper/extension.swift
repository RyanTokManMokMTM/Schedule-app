//
//  extension.swift
//  MySchedule
//
//  Created by JacksonTmm on 24/11/2021.
//

import SwiftUI

extension Font{
    static func AmaticSCBold(size:CGFloat) -> Font{
        Font.custom("AmaticSC-Bold", size: size)
    }
    
//    static funcw
}

struct AmaticSCBoldFont : ViewModifier{
    var size : CGFloat = 18
    func body(content: Content) -> some View {
        content.font(.AmaticSCBold(size: size))
    }
}

extension View{
    func amaticBoldFont(size : CGFloat) -> some View{
        ModifiedContent(content: self,modifier: AmaticSCBoldFont(size: size))
    }
}
