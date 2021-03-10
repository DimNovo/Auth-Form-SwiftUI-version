//
//  RegisterViewModel.swift
//  Auth Form SwiftUI version
//
//  Created by Dmitry Novosyolov on 10/03/2021.
//

import SwiftUI

final class RegisterViewModel: ObservableObject {
    
    @Published
    var customAlert: CustomAlert? = nil
    
    @Published
    var confirmPassword = ""
    
    ///# Registration permission check method
    func registerPermission(_ user: User) -> Bool {
        !user.email.isEmpty && !user.password.isEmpty && passwordIdenticPermission(user)
    }
    
    ///# User registration method
    func action(_ user: Binding<User>, _ presentationMode: Binding<PresentationMode>) {
        switch user.wrappedValue.email.isEmail {
        case true:
            switch registerPermission(user.wrappedValue) {
            case true:
                guard userDuplicatePermission(user.wrappedValue) else {
                    customAlert = .error("User is already exists") { [self] in clearInput(user) }
                    return
                }
                ///# The New user is created - handle some of your logic here...
                createNewUser(user.wrappedValue)
                customAlert = .notification("User:\n\(user.wrappedValue.email.lowercased())\nsuccessfully registered!") { [self] in
                    clearInput(user)
                    presentationMode.wrappedValue.dismiss()
                }
            case false:
                ///# Default case
                customAlert = .error("Unknown error\nplease try again latter") { [self] in clearInput(user) }
            }
        case false:
            ///# The invalid email case ...
            customAlert = .error("Please,\nenter valid email address.") { user.wrappedValue.email.removeAll() }
        }
    }
    
    ///# Passwords identic permission check method
    private func passwordIdenticPermission(_ user: User) -> Bool {
        !user.password.isEmpty && user.password == confirmPassword
    }
    
    ///# Duplicate user's account check method
    private func userDuplicatePermission(_ user: User) -> Bool {
        !User.demoUsers.map(\.email).contains(user.email.lowercased())
    }
    
    ///# Create new user method
    private func createNewUser(_ user: User) {
        User.demoUsers.append(
            .init(
                email: user.email.lowercased(),
                password: user.password)
        )
    }
    
    ///# Clear input method
    private func clearInput(_ user: Binding<User>) {
        DispatchQueue.main.async { [self] in
            user.wrappedValue.email.removeAll()
            user.wrappedValue.password.removeAll()
            confirmPassword.removeAll()
        }
    }
}
