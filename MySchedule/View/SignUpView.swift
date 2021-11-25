//
//  Sigin.swift
//  MySchedule
//
//  Created by JacksonTmm on 24/11/2021.
//

import SwiftUI

struct SignUpView: View {
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var confirmPasswod : String = ""
    @State private var fullName : String = ""
       
    @State private var isCheck : Bool = false
    
    @Binding var isActive : Bool
    var body: some View {
        VStack{
//            Spacer()
            SignUpHeader()
            SignUpInfo()
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color("MainBG"))
        .edgesIgnoringSafeArea(.all)
        
    }
    
    @ViewBuilder
    func SignUpHeader() -> some View{
        VStack(alignment:.leading){
            Spacer()
            HStack{
                VStack(alignment:.leading){
                    Spacer()
                    Button(action:{
                        withAnimation(){
                            self.isActive.toggle()
                        }
                    }){
                            Image(systemName: "arrow.left")
                                .font(.title)
                                .foregroundColor(.black)
    
                    }
                    .frame(width: 25, height: 25)
                    
                    Spacer()
                    Text("Create\nAccount!")
                        .bold()
                        .font(.system(size: 30))
                }
                
                Spacer()
            }
            .padding(.bottom,20)
            
        }
        .frame(width: UIScreen.main.bounds.width - 50)
        .edgesIgnoringSafeArea(.all)
        .frame(width: UIScreen.main.bounds.width, height: 200)
        .background(Color.white.clipShape(CustomConer(coners: [.bottomLeft]) ).edgesIgnoringSafeArea(.bottom))
//        .shadow(color: .gray, radius: 10, x: 0, y: 0)
    }
    
    @ViewBuilder
    func SignUpInfo() -> some View {
        VStack(alignment:.leading){
            VStack(spacing:25){
                TextField("Email", text:self.$email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                
                TextField("FullName", text:self.$fullName)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                
                SecureField("Password", text:self.$password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                SecureField("Confirm Password", text:self.$confirmPasswod)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
            }

            HStack{
                
                Image(systemName: self.isCheck ? "checkmark.square.fill" : "square.fill")
                    .font(.body)
                    .foregroundColor(.white)
                    .onTapGesture {
                        withAnimation{
                            self.isCheck.toggle()
                        }
                    }
                
                Text("Agree to teams and condition")
                    .foregroundColor(Color.white.opacity(0.7))
                    .font(.body)
                    .bold()
            }
            .padding(.top,20)
            Spacer()
            Button(action:{
                
            }){
                Text("Sign Up")
                    .bold()
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth:.infinity)
                    .background(Color.white)
                    .cornerRadius(15)
            }
            
            HStack{
                Text("Already have an account?")
                    .bold()
                
                Spacer()
                
                Button(action:{
                    
                }){
                    Text("SignIn")
                        .foregroundColor(.white)
                        .bold()
                        .font(.body)
                }
                
            }
            .foregroundColor(Color.white.opacity(0.7))
            .padding(.top)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
    }
}
//
//struct SignUp_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
