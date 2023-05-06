//
//  HomeViewModel.swift
//  SwiftuiCrypto
//
//  Created by Lori Rothermel on 5/2/23.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var statistics: [StatisticModel] = []
        
     
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }  // init

    
    func addSubscribers() {
        
        // Updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)    // Waits 0.5 seconds to run code
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }  // .sink
            .store(in: &cancellables)
        
        // Updates marketData
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self ] returnedStats in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
        
        // Updates PortfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coinModels, portfolioEntities) -> [CoinModel] in
                coinModels
                    .compactMap { coin -> CoinModel? in
                        guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                            return nil
                        }  // guard let
                        return coin.updateHoldings(amount: entity.amount)
                    }  // .compactMap
            }  // .map
            .sink { [weak self] returnedCoins in
                self?.portfioCoins = returnedCoins
            }  // .sink
            .store(in: &cancellables)
    }  // func addSubscribers
    
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
        
        
    }  // updatePortfolio
    
    
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else { return coins }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { coin -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
                   coin.symbol.lowercased().contains(lowercasedText) ||
                   coin.id.lowercased().contains(lowercasedText)
        }
        
        
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel] {
        
        var stats: [StatisticModel] = []
        guard let data = marketDataModel else { return stats }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
        
        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
        
        return stats
    }
    
}
