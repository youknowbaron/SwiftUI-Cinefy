//
//  LoginScreen.swift
//  Cinefy
//
//  Created by vobach on 12/05/2021.
//

import SwiftUI

struct LoginScreen: View {
    
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            Text("C I N E F Y")
                .font(.system(size: 40.0, weight: .thin, design: .monospaced))
                .padding(.bottom, 60)
            
            VStack(spacing: 20) {
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                SecureField("Password", text: $password)
                    .padding(.bottom, 20)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                }
                .background(Color.buttonColor)
                .cornerRadius(20)
                .padding(.horizontal, 40)
            }
            .padding(25)
        }
        .foregroundColor(.textColor)
        .textFieldStyle(MyTextFieldStyle())
    }
}

struct MyTextFieldStyle : TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(15)
            .background(Color.buttonColor)
            .cornerRadius(20)
            .foregroundColor(.white)
            .frame(height: 44)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
