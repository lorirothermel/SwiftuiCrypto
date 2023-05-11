//
//  SwiftuiCryptoApp.swift
//  SwiftuiCrypto
//
//  Created by Lori Rothermel on 5/1/23.
//

import SwiftUI

@main
struct SwiftuiCryptoApp: App {
    @StateObject private var vm = HomeViewModel()
    @State private var showLaunchView: Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack {
                    HomeView()
                        .navigationBarHidden(true)
                }  // NavigationStack
                .environmentObject(vm)
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }  // if
                }  // ZStack
                .zIndex(2.0)
            }  // ZStack
        }  // WindowGroup
    }  // some Scene
}  // SwiftuiCryptoApp
