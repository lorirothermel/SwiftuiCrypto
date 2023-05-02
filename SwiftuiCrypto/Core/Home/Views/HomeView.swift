//
//  HomeView.swift
//  SwiftuiCrypto
//
//  Created by Lori Rothermel on 5/1/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
        
    @State private var showPortfolio: Bool = false
    
    
    
    var body: some View {
        ZStack {
            // Background Layer
            Color.theme.background
                .edgesIgnoringSafeArea(.all)
            
            // Content Layer
            VStack {

                homeHeader
                columnTitles
                
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }  // if
                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }  // if
                                
                Spacer(minLength: 0)
            }  // VStack
        }  // ZStack
    }  // some View
}  // HomeView

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
                .navigationBarHidden(true)
        }  // NavigationStack
        .environmentObject(dev.homeVM)
    }
}


extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .background(CircleButtonAnimationView(animate: $showPortfolio))
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
                .animation(.none, value: showPortfolio)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }  // withAnimation
                }  // .onTapGesture
        }  // HStack
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }  // ForEach
        }  // List
        .listStyle(.plain)
    }
    
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }  // ForEach
        }  // List
        .listStyle(.plain)
    }
    
    private var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }  // if
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }  // HStack
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .padding(.horizontal)
    }
    
    
    
    
}


