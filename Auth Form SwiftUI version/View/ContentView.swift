//
//  ContentView.swift
//  Auth Form SwiftUI version
//
//  Created by Dmitry Novosyolov on 10/03/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LoginView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserViewModel())
    }
}
