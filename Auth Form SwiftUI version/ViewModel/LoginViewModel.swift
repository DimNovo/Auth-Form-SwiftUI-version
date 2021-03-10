//
//  LoginViewModel.swift
//  Auth Form SwiftUI version
//
//  Created by Dmitry Novosyolov on 10/03/2021.
//

import Foundation

final class LogiViewModel: ObservableObject {
    
    @Published
    var customAlert: CustomAlert? = nil
    
    @Published
    var isPresented = false
    
    ///# Login permission check method
    func loginPermission(_ user: User) -> Bool {
        !user.email.isEmpty && !user.password.isEmpty
    }
    
    ///# User login method
    func action(_ user: User) {
        switch loginAccountCheck(user) {
        case true:
            ///# The logged-in user is ready to use ...
            customAlert = .notification("User: \(user.email.lowercased())\nsuccessfully logged in!")
                { [self] in customAlert = nil }
        case false:
            ///# The user isn't found in our database - so register a new user
            customAlert = .error("User with\ncurrent email / password\ndoesn't exist")
                { [self] in customAlert = nil }
        }
    }
    
    ///# Login account check method
    private func loginAccountCheck(_ user: User) -> Bool {
        User.demoUsers
            .allSatisfy {
                $0.email.contains(user.email.lowercased()) &&
                    $0.password.contains(user.password)
            }
    }
}
