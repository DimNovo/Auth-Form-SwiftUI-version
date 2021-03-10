//
//  CustomAlert.swift
//  Auth Form SwiftUI version
//
//  Created by Dmitry Novosyolov on 10/03/2021.
//

import SwiftUI

enum CustomAlert: Identifiable {
    typealias Action = () -> Void
    var id: String { UUID().uuidString }
    case notification(String, Action), error(String, Action)
    var alertView: Alert {
        switch self {
        case .notification(let message, let action):
            return
                .init(
                    title: Text("Notification"),
                    message: Text(message),
                    dismissButton: .default(Text("OK"),
                                            action: action))
        case .error(let message, let action):
            return
                .init(
                    title: Text("Error"),
                    message: Text(message),
                    dismissButton: .destructive(Text("OK"),
                                                action: action))
        }
    }
}
