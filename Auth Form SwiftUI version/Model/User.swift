//
//  User.swift
//  Auth Form SwiftUI version
//
//  Created by Dmitry Novosyolov on 10/03/2021.
//

import Foundation

struct User {
    var email, password: String
}

///# Users database
extension User: Equatable {
    static var demoUsers: [Self] = [.init(email: "demo@mail.com", password: "123123")]
}
