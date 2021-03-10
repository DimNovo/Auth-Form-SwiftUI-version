//
//  UserViewModel.swift
//  Auth Form SwiftUI version
//
//  Created by Dmitry Novosyolov on 10/03/2021.
//

import Foundation

final class UserViewModel: ObservableObject {
    
    @Published
    var user: User
    
    init() {
        user = User.demoUsers[0]
    }
}
