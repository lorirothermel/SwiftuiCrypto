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
    
    
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .navigationBarHidden(true)
            }  // NavigationStack
            .environmentObject(vm)
        }  // WindowGroup
    }  // some Scene
}  // SwiftuiCryptoApp
