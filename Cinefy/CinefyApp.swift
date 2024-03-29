//
//  CinefyApp.swift
//  Cinefy
//
//  Created by vobach on 12/05/2021.
//

import SwiftUI

@main
struct CinefyApp: App {
    
    @StateObject var userViewModel = UserViewModel(apiService: APIServiceImpl())
    
    init() {
        setupApperance()
    }
    
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
                .environmentObject(userViewModel)
                .preferredColorScheme(.dark)
        }
    }
    
    private func setupApperance() {
        UIWindow.appearance().tintColor = UIColor(named: "steam_gold")
    }
}

extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // set to `false` if you don't want to detect tap during other gestures
    }
}
