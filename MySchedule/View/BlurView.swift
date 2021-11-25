//
//  BlurView.swift
//  MySchedule
//
//  Created by Jackson on 17/11/2021.
//

import Foundation
import SwiftUI

struct BlurView : UIViewRepresentable{
    var style : UIBlurEffect.Style = .systemUltraThinMaterialDark
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}
