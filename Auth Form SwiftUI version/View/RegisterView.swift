//
//  RegisterView.swift
//  Auth Form SwiftUI version
//
//  Created by Dmitry Novosyolov on 10/03/2021.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject
    var userVM: UserViewModel
    @Environment(\.presentationMode)
    var presentationMode
    @StateObject
    private var registerVM = RegisterViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(
                        header:
                            Text("Create account")
                            .font(.headline)) {
                        TextField("email...", text: $userVM.user.email)
                            .keyboardType(.emailAddress)
                        SecureField("password...", text: $userVM.user.password)
                        if !(userVM.user.password.isEmpty) {
                            SecureField("confirm password...", text: $registerVM.confirmPassword)
                        }
                    }
                }
                Button(
                    action: {
                        registerVM.action($userVM.user, presentationMode.animation())
                    },
                    label: {
                        Text("Register")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(
                                width: UIScreen.main.bounds.width / 1.2,
                                height: 45)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 10,
                                    style: .continuous)
                                    .fill(!registerVM.registerPermission(userVM.user) ? .secondary : Color.blue))
                            .opacity(registerVM.registerPermission(userVM.user) ? 0.85 : 0.35)
                    })
                    .padding(.vertical)
                    .disabled(!registerVM.registerPermission(userVM.user))
            }
            .navigationTitle("Register")
            .navigationBarItems(
                trailing: Button(
                    action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                )
            )
        }
        .alert(item: $registerVM.customAlert) { $0.alertView }
        .onAppear {
            userVM.user.password.removeAll(); userVM.user.email.removeAll()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .environmentObject(UserViewModel())
    }
}
