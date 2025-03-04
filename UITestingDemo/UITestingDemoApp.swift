//
//  UITestingDemoApp.swift
//  UITestingDemo
//
//  Created by Ahmed Refat on 04/03/2025.
//

import SwiftUI

@main
struct UITestingDemoApp: App {
    var body: some Scene {
        WindowGroup {
            UITestingBootcampView(currentUserIsSignedIn: false)
        }
    }
}
