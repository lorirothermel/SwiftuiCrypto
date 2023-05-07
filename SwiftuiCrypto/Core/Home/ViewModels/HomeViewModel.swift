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
    @Published var isLoading: Bool = false
     
    
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
        
        // Updates PortfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] returnedCoins in
                self?.portfioCoins = returnedCoins
            }  // .sink
            .store(in: &cancellables)
        
        // Updates marketData
        marketDataService.$marketData
            .combineLatest($portfioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self ] returnedStats in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
     
    }  // func addSubscribers
    
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
        
    }  // updatePortfolio
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else { return coins }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { coin -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
                   coin.symbol.lowercased().contains(lowercasedText) ||
                   coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins
            .compactMap { coin -> CoinModel? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }  // guard let
                return coin.updateHoldings(amount: entity.amount)
            }  // .compactMap
    }
    
    
    
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        
        var stats: [StatisticModel] = []
        guard let data = marketDataModel else { return stats }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = portfolioCoins.map { $0.currentHoldingsValue }
                                           .reduce(0, +)
               
        let previousValue = portfolioCoins.map { coin -> Double in
                                                let currentValue = coin.currentHoldingsValue
                                                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                                                let previousValue = currentValue / ( 1 + percentChange )
                                                return previousValue
                                               }
                                          .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
        
        return stats
    }
    
    
    
    
}
