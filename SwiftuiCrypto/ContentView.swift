//
//  ContentView.swift
//  SwiftuiCrypto
//
//  Created by Lori Rothermel on 5/1/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 25) {
                Text("Accent Color")
                    .foregroundColor(.theme.accent)
                Text("Secondary Text Color")
                    .foregroundColor(.theme.secondaryText)
                Text("Red Color")
                    .foregroundColor(.theme.red)
                Text("Green Color")
                    .foregroundColor(.theme.green)
            }  // VStack
            .font(.headline)
            
        }  // ZStack
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
