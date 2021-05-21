////
////  LoginScreen.swift
////  Cinefy
////
////  Created by vobach on 12/05/2021.
////
//
//import SwiftUI
//
//struct LoginScreen: View {
//
//    @ObservedObject var viewModel = LoginViewModel(apiService: APIServiceImpl())
//
//    @State var username: String = "patricklagger"
//    @State var password: String = "31121995"
//
//    var body: some View {
//        ZStack {
//            Color.bgColor.ignoresSafeArea()
//
//            VStack {
//                Image("logo_cinefy")
//                    .frame(width: 200)
//                    .padding(.bottom, 60)
//
//                VStack(spacing: 20) {
//                    TextField("Username", text: $username)
//                        .autocapitalization(.none)
//                        .keyboardType(.emailAddress)
//
//                    SecureField("Password", text: $password)
//                        .padding(.bottom, 20)
//
//                    MyButton("Login", horizontalMargin: 40) {
//                        viewModel.login(username: username, password: password)
//                    }.alert(isPresented: .constant(viewModel.shouldShowAlert)) {
//                        var message = "Unknown error"
//
//                        if case .failed(error: let e) = viewModel.state,
//                           let errorDescription = (e as? APIError)?.errorDescription {
//                            message = errorDescription
//                        }
//
//                        return Alert(
//                            title: Text("Error"),
//                            message: Text(message),
//                            dismissButton: .default(Text("OK"))
//                        )
//                    }
//                }
//                .padding(25)
//            }
//
//            if case .loading = viewModel.state {
//                ProgressView("Loading")
//                    .padding()
//                    .buttify(backgroundColor: .white.opacity(0.25))
//            }
//        }
//        .foregroundColor(.textColor)
//        .textFieldStyle(MyTextFieldStyle())
//        .onAppear {
//            viewModel.getRquestToken()
//        }
//        .navigate(to: MainScreen(), when: .constant(viewModel.isLoginSuccess))
//    }
//}
//
//
//struct MyTextFieldStyle : TextFieldStyle {
//    func _body(configuration: TextField<Self._Label>) -> some View {
//        configuration
//            .padding(15)
//            .background(Color.buttonColor)
//            .cornerRadius(20)
//            .foregroundColor(.white)
//            .frame(height: 44)
//    }
//}
//
//struct LoginScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginScreen()
//    }
//}
