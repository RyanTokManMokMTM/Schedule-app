//
//  LoginView.swift
//  MySchedule
//
//  Created by JacksonTmm on 24/11/2021.
//

import SwiftUI

struct HomeView: View {
    @State private var index = 0
    @State private var isLogin = false
    @State private var isSignup = false
    var body: some View {
        NavigationView{
            ZStack{
                ScrollView{
                    TabView(selection: self.$index){
                        ForEach(0..<5){i in
                            Image("loginBG\(i)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height )
                                .clipped()
                            //                        .offset(y:-100)
                                .overlay(
                                    Color("MainBG").opacity(0.65).edgesIgnoringSafeArea(.all)
                                )
                                .edgesIgnoringSafeArea(.all)
                            
                            //                        .clipped()
                            
                        }
                        .ignoresSafeArea()
                    }
                    .frame( width: UIScreen.main.bounds.width ,height: UIScreen.main.bounds.height)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
                .edgesIgnoringSafeArea(.top)
                
                VStack{
                    VStack(alignment:.leading){
                        HStack{
                            Text("Life Style")
                                .bold()
                                .font(.custom("BungeeOutline-Regular", size: 20))
                                .foregroundColor(Color.white)
                                .padding(.top)
                            
                            Spacer()
                        }
                        
                        
                        Spacer()
                        Text("Start a new \n\tlift advantage .")
                            .bold()
                            .foregroundColor(.white)
                            .amaticBoldFont(size:50)
                        
                        
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    Spacer()
                    
                    HStack{
                        ForEach(0..<5){i in
                            
                            Circle()
                                .fill(Color.white.opacity(i == index ? 1 : 0.1))
                                .foregroundColor(.white)
                                .scaleEffect(i == index ? 1.2 : 1)
                                .frame(width: 5, height: 5)
                                .animation(.spring(),value:i == index)
                            
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.bottom,5)
                    
                    loginInfo()
                    
                }
                
                NavigationLink("",destination:SignInView(isActive: $isLogin).navigationBarTitle("").navigationBarBackButtonHidden(true).edgesIgnoringSafeArea(.all),isActive:$isLogin)
                NavigationLink("", destination:SignUpView(isActive: $isSignup).navigationBarTitle("").navigationBarBackButtonHidden(true).edgesIgnoringSafeArea(.all),isActive:$isSignup)
                
      
            }
            .navigationBarTitle("")
            .navigationTitle("")
            .navigationBarHidden(true)
        }


    }
    
    
    @ViewBuilder
    func loginInfo() -> some View{
        VStack(alignment:.leading){

            Text("To Manage your own time and daily events!")
                .kerning(2)
                .foregroundColor(Color.black.opacity(0.65))
                .bold()
//                .font(.system(size: 18))
                .font(.custom("Lobster-Regular", size: 18))
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .padding(.vertical)
               

            Button(action:{
                //LOGIN
                withAnimation(){
                    self.isLogin.toggle()
                }
            }){
                Text("LOGIN")
                    .bold()
                    .font(.body)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("MainBG"))
                    .cornerRadius(10)
            }
            
            HStack{
                Spacer()
                Button(action:{
                    withAnimation(){
                        self.isSignup.toggle()
                    }
                }){
                    HStack{
                        Text("Or create new acccount")
                            .foregroundColor(.black)
                            .font(.body)
                            .bold()
                        
                        Image(systemName: "arrow.right")
                            .foregroundColor(.black)
                           
                    }
                }
            }
            .padding(.vertical)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 50)
        .edgesIgnoringSafeArea(.all)
        .frame(width: UIScreen.main.bounds.width, height: 200)
        .background(Color.white.clipShape(CustomConer(width: 35, height: 35, coners: [.topRight]) ).edgesIgnoringSafeArea(.bottom))
        .shadow(color: .gray, radius: 10, x: 0, y: 0)

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
