//
//  LoginView.swift
//  Auth Form SwiftUI version
//
//  Created by Dmitry Novosyolov on 10/03/2021.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject
    var userVM: UserViewModel
    @StateObject
    private var loginVM = LogiViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("enter account").font(.headline)) {
                        TextField("email...", text: $userVM.user.email)
                            .keyboardType(.emailAddress)
                        SecureField("password...", text: $userVM.user.password)
                    }
                }
                VStack(alignment: .center, spacing: 15) {
                    Button(
                        action: {
                            loginVM.action(userVM.user)
                        },
                        label: {
                            Text("Login")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(
                                    width: UIScreen.main.bounds.width / 1.2,
                                    height: 44)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 10,
                                        style: .continuous)
                                        .fill(
                                            !loginVM.loginPermission(userVM.user) ?
                                                .secondary :
                                                Color.blue))
                                .opacity(loginVM.loginPermission(userVM.user) ? 0.85 : 0.35)
                        })
                        .disabled(!loginVM.loginPermission(userVM.user))
                    Button(
                        action: {
                            loginVM.isPresented.toggle()
                        },
                        label: {
                            Text("Don't have an account?")
                        }
                    )
                }
                .padding(.vertical)
            }
            .navigationTitle("Login")
            .onAppear {
                userVM.user.password.removeAll(); userVM.user.email.removeAll()
            }
        }
        .alert(item: $loginVM.customAlert) { $0.alertView }
        .fullScreenCover(isPresented: $loginVM.isPresented) {
            RegisterView()
                .environmentObject(userVM)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(UserViewModel())
    }
}
