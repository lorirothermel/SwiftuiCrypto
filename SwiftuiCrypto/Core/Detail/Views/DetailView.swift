//
//  DetailView.swift
//  SwiftuiCrypto
//
//  Created by Lori Rothermel on 5/8/23.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }  // if let
        }  // ZStack
    }  // some View
}  // DetailLoadingView
    
   


struct DetailView: View {
    @StateObject private var vm: DetailViewModel
    @State private var showFullDescription: Bool = false
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30
    
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }  // init
        
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing: 20) {
                    overviewTitle
                    Divider()
                    descriptionSection
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    websiteSection
                }  // VStack
                .padding()
            }  // VStack
        }  // ScrollView
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItems
            }  // ToolbarItem
        }  // .toolbar
    }  // some View
}  // DetailView


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(coin: dev.coin)
        }
        
    }
}

extension DetailView {
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }  // overviewTitle
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }  // additionalTitle
    
    
    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = vm.coinDescription,
               !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.subheadline)
                        .foregroundColor(.theme.secondaryText)
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Less" : "Read more...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 2)
                    }  // Button
                    .accentColor(.blue)
                }  // VStack
                .frame(maxWidth: .infinity, alignment: .leading)
            }  // if let
        }  // ZStack
    }  // descriptionSection
    
    
    private var overviewGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: []) {
            ForEach(vm.overviewStatistics) { stat in
                StatisticView(stat: stat)
            }  // ForEach
        }  // LazyVGrid
    }  // overviewGrid
    
    private var additionalGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: []) {
            ForEach(vm.additionalStatistics) { stat in
                StatisticView(stat: stat)
            }  // ForEach
        }  // LazyVGrid
    }  // additionalGrid
    
    private var navigationBarTrailingItems: some View {
        HStack() {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }  // HStack
    }  // navigationBarTrailingItems
    
    
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let websiteString = vm.websiteURL,
               let url = URL(string: websiteString) {
                    Link("Website: ", destination: url)
            }  // if let
            
            if let redditString = vm.redditURL,
               let url = URL(string: redditString) {
                    Link("Reddit: ", destination: url)
            }  // if let
        }  // VStack
        .accentColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }  // websiteSection
    
    
}  // extension DetailView

