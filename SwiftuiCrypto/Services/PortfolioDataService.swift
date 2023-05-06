//
//  PortfolioDataService.swift
//  SwiftuiCrypto
//
//  Created by Lori Rothermel on 5/6/23.
//

import Foundation
import CoreData


class PortfolioDataService {
    @Published var savedEntities: [PortfolioEntity] = []
    
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            
            if let error = error {
                print("ERROR: Error loading Core Data! \(error.localizedDescription)")
            }  // if let
            self.getPortfolio()
        }  // container.loadPersistentStores
    }  // init
    
    
    // MARK: Public Functions
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        
        // Check if coin is already in the portfolio
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }  // if let
    }  // updatePortfolio
        
    
    // MARK: Private Functions
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("ERROR: Error fetching Portfolio Entities. \(error.localizedDescription)")
        }  // do...catch
    }  // getPortfolio
    
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        
        applyChanges()
        
    }  // add
    
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("ERROR: Error saving to Core Data. \(error.localizedDescription)")
        }  // do...catch
        
    }  // save
    
    
    private func applyChanges() {
        save()
        getPortfolio()
    }  // applyChanges
    
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }  // update
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }  // delete
 
    
}  // class PortfolioDataService

