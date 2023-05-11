//
//  LaunchView.swift
//  SwiftuiCrypto
//
//  Created by Lori Rothermel on 5/11/23.
//

import SwiftUI

struct LaunchView: View {
    @State private var loadingText: [String] = "Downloading all the Data...".map { String($0) }
    @State private var showLoadingText: Bool = false
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    
    @Binding var showLaunchView: Bool
    
    
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .frame(width: 100, height: 100)
            
            ZStack {
                if showLoadingText {
//                    Text(loadingText)
//                        .font(.headline)
//                        .fontWeight(.heavy)
//                        .foregroundColor(.launch.accent)
//                        .transition(AnyTransition.scale.animation(.easeIn))
                    
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(.launch.accent)
                                .offset(y: counter == index ? -10 : 0)
                        }  // ForEach
                    }  // HStack
                    .transition(AnyTransition.scale.animation(.easeIn))
                    
                }  // if
                
                
            }  // ZStack
            .offset(y: 70)
        }  // ZStack
        .onAppear {
            showLoadingText.toggle()
        }  // .onAppear
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                let lastIndex = loadingText.count - 1
                
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    
                    if loops >= 2 {
                        showLaunchView = false
                    }  // if
                } else {
                    counter += 1
                }  // if...else
                
                
            }  // withAnimation
        }  // .onReceive
    }  // some View
}  // LaunchView

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
