//
//  HomeViewModel.swift
//  SwiftuiCrypto
//
//  Created by Lori Rothermel on 5/2/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfioCoins: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portfioCoins.append(DeveloperPreview.instance.coin)
        }
    }
}
