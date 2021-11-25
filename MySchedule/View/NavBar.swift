//
//  NavBar.swift
//  MySchedule
//
//  Created by Jackson on 18/11/2021.
//

import SwiftUI

struct NavBar: View {
    @Binding var dismiss : Bool
    @Binding var animateBackground : Bool
    @Binding var animatePath : Bool
    var body: some View {
        
        ZStack{
            BlurView()
               
            Color("BG")
                .opacity(0.5)
                .blur(radius: 15)
            
            VStack(alignment:.leading , spacing: 25){
                Button(action: {
                    
                    withAnimation(Animation.interactiveSpring(response: 0.4, dampingFraction: 0.3, blendDuration: 0.3)){
                        self.animatePath.toggle()
                    }
                    
                    withAnimation{
                        self.animateBackground.toggle()
                    }
                    
                    withAnimation(Animation.spring().delay(0.1)){
                        self.dismiss.toggle()
                    }
                    
                }){
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.white)
                        .font(.title)
                }
                
                MenuButton(title: "Scheduler", image: "calendar.badge.plus", offset: 0)
                    .padding(.top)
                MenuButton(title: "Timer", image: "timer", offset: 10)
                
                MenuButton(title: "My Account", image: "user", offset: 30)
                
                MenuButton(title: "Uasge", image: "chart.bar.xaxis", offset: 10)
                
                MenuButton(title: "Help", image: "questionmark.circle", offset: 0)
                
                Spacer()
                
                MenuButton(title: "LOGOUT", image: "arrow.uturn.backward.square", offset: 0)
            }
            .padding(.trailing,120)
            .padding()
//            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
//            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .padding()
            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .topLeading)
        }
        .clipShape(NavShape(value: self.animatePath ? 150 : 0))
        .background(
            NavShape(value: self.animatePath ? 150 : 0)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [
                        Color("NavBorder"),
                        Color("NavBorder")
                            .opacity(0.7),
                        Color("NavBorder")
                            .opacity(0.5),
                        Color.clear
                    ]),startPoint: .top,endPoint: .bottom),lineWidth: self.animatePath ? 7 : 0
                )
//                .padding(.leading,-120)
        )
        .ignoresSafeArea()
        .onTapGesture {
            
            withAnimation(Animation.interactiveSpring(response: 0.4, dampingFraction: 0.3, blendDuration: 0.3)){
                self.animatePath.toggle()
            }
            
            withAnimation{
                self.animateBackground.toggle()
            }
            
            withAnimation(Animation.spring().delay(0.1)){
                self.dismiss.toggle()
            }
            
        }
        
        
    }
    
    
    @ViewBuilder
    func MenuButton(title:String,image:String,offset:CGFloat) -> some View{
        
        Button(action: {
            
        }){
            HStack(spacing:12){
                if image == "user"{
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                }else{
                    Image(systemName: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                }
                
                Text(title)
                    .font(.system(size: 17))
                    .foregroundColor(Color.white.opacity(0.65))
                    .fontWeight(title == "LOGOUT" ? .semibold : .medium)
                    .kerning(title == "LOGOUT" ? 1.2 : 0.8) //spacing between each character
                
//                    .fontWeight(.medium)
            }
            .padding(.vertical)
        }.offset(x:offset)
    }
    
}
////
//struct NavBar_Previews: PreviewProvider {
//    static var previews: some View {
//        NavBar(dismiss: .constant(<#T##value: Bool##Bool#>))
//    }
//}

struct NavShape : Shape{
    var value : CGFloat
    
    var animatableData: CGFloat{
        get{return value}
        set{value = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path{path in
            //Total width
            let width = rect.width - 100
            let height = rect.height
            
            //Draw the retangle 0.0 -> 0.h -> w,h -> w,0
            path.move(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: width, y: 0))
            
            path.move(to: CGPoint(x: width, y: 0))
            path.addCurve(to: CGPoint(x: width, y: height+value),
                          control1: CGPoint(x: width + value, y: height/3),
                          control2: CGPoint(x: width - value, y: height/2))
        }
    }
}
