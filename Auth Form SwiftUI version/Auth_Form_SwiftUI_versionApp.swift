//
//  Auth_Form_SwiftUI_versionApp.swift
//  Auth Form SwiftUI version
//
//  Created by Dmitry Novosyolov on 10/03/2021.
//

import SwiftUI

@main
struct Auth_Form_SwiftUI_versionApp: App {
    @StateObject
    private var userVM = UserViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userVM)
        }
    }
}
