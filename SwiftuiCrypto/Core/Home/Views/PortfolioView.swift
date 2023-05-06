//
//  PortfolioView.swift
//  SwiftuiCrypto
//
//  Created by Lori Rothermel on 5/5/23.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                   SearchBarView(searchText: $vm.searchText)
                   coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputSelection
                    }  // if
                }  // VStack
            }  // ScrollView
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }  // ToolbarItem
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButtons
                }  // ToolbarItem
            })  // .toolbar
        }  // NavigationStack
    }
}


struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
    
    
}

extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }  // withAnimation
                        }  // .onTapGesture
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                        )  // .background
                }  // ForEach
            }  // LazyHStack
            .frame(height: 120)
            .padding(.leading)
        }  // ScrollView
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInputSelection: some View {
        VStack {
            HStack {
                Text("Current Price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }  // HStack
            Divider()
            HStack {
                Text("Amount Holding:")
                Spacer()
                TextField("Ex: 1.4...", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }  // HStack
            Divider()
            HStack {
                Text("Current Value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }  // HStack
        }  // VStack
        .animation(nil, value: selectedCoin?.id)
        .padding()
        .font(.headline)
    }
    
    
    private var trailingNavBarButtons: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
            }  // Button
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
            )
        }  // HStack
        .font(.headline)
    }
    
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin else { return }
        
        // save to portfolio
        
        // save checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }  // withAnimation
        
        // Hide keyboard
        UIApplication.shared.endEditing()
        
        // Hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }  // withAnimation
        }  // DispatchQueue
               
    }  // func saveButtonPressed
    
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
    
    
}
