//
//  LoginView.swift
//  CourseApp
//
//  Created by Sean.S.Nguyen on 26/12/20.
//  Copyright © 2020 Sean.S.Nguyen. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @State var rotating = false
    @State var translation = CGSize.zero
    
    @State var email = ""
    @State var password = ""
    
    @State var isFocused = false
    @State var alertMessage = "Something went wrong."
    @State var showAlert = false
    @State var isLoading = false
    @Binding var authenticated: Bool

    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.edgesIgnoringSafeArea(.all)
            Color("background2")
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .edgesIgnoringSafeArea(.bottom)
            
            VStack(spacing: 30) {
                Spacer()
                GeometryReader { geometry in
                    Text("Learn Cloud & Code from scratch")
                        .font(.system(size: geometry.size.width / 12, weight: .bold, design:.rounded))
                        .frame(maxWidth: 375)
                        .padding(.horizontal, screen.width - 375)
                        .frame(height: 100, alignment: .center)
                        .offset(x: translation.width/15, y: translation.height/15)
                }
                    .foregroundColor(.white)
                
                Text("80 hours of courses \nfrom major cloud providers")
                    .foregroundColor(.black)
                    .offset(x: translation.width/20, y: translation.height/20)
                
                Image(uiImage: #imageLiteral(resourceName: "Card3"))
                    .aspectRatio(contentMode: .fit)
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .frame(height: 450)
            .background(
                ZStack {
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        .offset(x: -150, y: -150)
                        .rotationEffect(rotating ? Angle(degrees: 360) : Angle(degrees: 0))
                    
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        .offset(x: -200, y: 200)
                        .rotationEffect(rotating ? Angle(degrees: 360) : Angle(degrees: 0))
                        .blendMode(.plusDarker)
                }
                .animation(Animation.linear(duration: 100).repeatForever(autoreverses: false))
            )
            .background(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .rotation3DEffect(Angle(degrees: 5), axis: (x: translation.height, y: translation.width, z: 0))
            .scaleEffect(translation != CGSize.zero ? 0.9 : 1)
            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.1))
            .gesture(
                DragGesture().onChanged { value in
                    translation = value.translation
                }
                .onEnded { _ in
                    translation = CGSize.zero
                }
            )
            
            VStack(spacing:10) {
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color(#colorLiteral(red: 0.1647058824, green: 0.1882352941, blue: 0.3882352941, alpha: 1)).opacity(0.1), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                    
                    TextField("Your Email".uppercased(), text: $password)
                        .keyboardType(.emailAddress)
                        .font(.subheadline)
                        .padding(.leading)
                        .frame(height: 44)
                        .onTapGesture {
                            self.isFocused = true
                        }
                }
                Divider()
                HStack {
                    Image(systemName: "lock.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color(#colorLiteral(red: 0.1647058824, green: 0.1882352941, blue: 0.3882352941, alpha: 1)).opacity(0.1), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                    
                    SecureField("Password".uppercased(), text: $email)
                        .font(.subheadline)
                        .padding(.leading)
                        .frame(height: 44)
                        .onTapGesture {
                            self.isFocused = true
                        }
                }
            }
            .frame(height: 136)
            .frame(maxWidth: .infinity)
            .background(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.1647058824, green: 0.1882352941, blue: 0.3882352941, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
            .padding(.horizontal, 16)
            .offset(y: 440)
            
            HStack {
                Text("Forgot password?")
                    .font(.subheadline)
                
                Spacer()
                
                Button(action: {
                    self.hideKeyboard()
                    self.isFocused = false
                    self.isLoading = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        if (email == "" && password == "") {
                            self.showAlert = true
                        } else {
                            self.authenticated = true
                            UserDefaults.standard.set(true, forKey: "Authenticated")
                        }
                        self.isLoading = false
                    }
                }) {
                    Text("Log in".uppercased())
                        .foregroundColor(.black)
                }
                .padding(12)
                .padding(.horizontal, 30)
                .background(Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message:
                            Text(self.alertMessage), dismissButton:
                            .default(Text("OK")))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding()
            
            if isLoading {
                VStack {
                    LoadingView()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            self.rotating = true
        }
//        .offset(y: isFocused ? -300 : 0)
//        .animation(isFocused ? .timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8) : .none)
//        .onTapGesture {
//            self.isFocused = false
//            self.hideKeyboard()
//        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(authenticated: .constant(true))
    }
}
