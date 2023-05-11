//
//  HomeView.swift
//  SwiftuiCrypto
//
//  Created by Lori Rothermel on 5/1/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
        
    @State private var showPortfolio: Bool = false          // Animate Right
    @State private var showPortfolioView: Bool = false      // New Sheet
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false
    @State private var showSettingsView: Bool = false
    
    
    var body: some View {
        ZStack {
            // Background Layer
            Color.theme.background
                .edgesIgnoringSafeArea(.all)
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(vm)
                }  // .sheet
            
            // Content Layer
            VStack {

                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                
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
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }  // .sheet
        }  // ZStack
        .background(
            NavigationLink(
                destination: DetailLoadingView(coin: $selectedCoin),
                isActive: $showDetailView,
                label: {
                    EmptyView()
                })
        )  // .background
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
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    } else {
                        showSettingsView.toggle()
                    }  // if...else
                }  // .onTapGesture
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
                    .onTapGesture {
                        seque(coin: coin)
                    }  // .onTapGesture
            }  // ForEach
        }  // List
        .listStyle(.plain)
    }
    
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        seque(coin: coin)
                    }  // .onTapGesture
            }  // ForEach
        }  // List
        .listStyle(.plain)
    }
    
    private func seque(coin: CoinModel) {
        selectedCoin = coin
        showDetailView.toggle()
    }
      
    
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity( (vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0 )
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }  // HStack
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }  // withAnimation
            }  // .onTapGesture
            
            Spacer()
            
            if showPortfolio {
                HStack {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity( (vm.sortOption == .holdings  || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0 )
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }  // HStack
                .onTapGesture {
                    withAnimation {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }  // withAnimation
                }  // .onTapGesture
            }  // if
            
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity( (vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0 )
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }  // HStack
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }  // withAnimation
            }  // .onTapGesture
                        
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }  // Buttton
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
        }  // HStack
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .padding(.horizontal)
    }
    
}


