//
//  ContentView.swift
//  MySchedule
//
//  Created by Jackson on 17/11/2021.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @StateObject var vm = ScheduleVM()
    var body: some View {
        Home()
            .environmentObject(vm)
            .statusBar(hidden: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Home : View {
    @State private var showNav : Bool = false
    @State private var animateBackground : Bool = false
    @State private var animatePath : Bool = false
    var body: some View{
        ZStack{
            CustomCalender(showNav: self.$showNav, animateBackground: self.$animateBackground, animatePath: self.$animatePath)
                .zIndex(0)
//                .offset(x: self.showNav ? UIScreen.main.bounds.width / 5 : 0 )
            Color.black
                .opacity(self.animateBackground ? 0.25 : 0)
                .ignoresSafeArea()
            NavBar(dismiss: self.$showNav, animateBackground: self.$animateBackground,animatePath: self.$animatePath)
                .zIndex(1)
                .offset(x:self.showNav ? 0 : -UIScreen.main.bounds.width)
//                .ignoresSafeArea()
            
        }
    }
}
