//
//  HomeViewModel.swift
//  Payback
//
//  Created by Emre Boyaci on 3.12.2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    var transactions: [Item] = []
    @Published var shownTransactions: [Item] = []
    @Published var transactionsSum: Int = 0
    @Published var isSumViewCollapsed: Bool = false
    @Published var categories: [Int] = []
    @Published var selectedCategory: Int? = nil
    @Published var isNetworkConnected: Bool = true
    @Published var errorOccurred: Bool = false
    @Published var hasMockTimeElapsed = false
    
    init() {
        tryLoading()
    }
    
    func tryLoading() {
        hasMockTimeElapsed = false
        errorOccurred = false
        if let transactions = parseTransactions() {
            self.transactions = transactions.items
            self.shownTransactions = transactions.items
        }
        self.transactionsSum = getTransactionSum(transactions)
        self.categories = getCategories(transactions)
    }
    
    func loadJSON() -> Data? {
        let randomInt = Int.random(in: 1..<20)
        //Mock error, low chance of occurance
        if randomInt == 1 {
            errorOccurred = true
            Task {
                try await delayMockError()
            }
        } else {
            errorOccurred = false
            if let path = Bundle.main.path(forResource: "test", ofType: "json") {
                do {
                    // Load the data from the file in the bundle
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    return data
                } catch {
                    print(error)
                }
            }
        }
        return nil
    }
    
    func parseTransactions() -> Transactions? {
        guard let transactionsData = loadJSON() else { return nil }
        
        do {
            // Decode the data. Codable helps us with this
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            var transactions = try decoder.decode(Transactions.self, from: transactionsData)
            
            // Sort the data by date
            transactions.items = sortTransactions(transactions.items)
            return transactions
        } catch {
            print(error)
        }
        return nil
    }
    
    func sortTransactions(_ transactions: [Item]) -> [Item] {
        return transactions.sorted(by: {$0.transactionDetail.bookingDate > $1.transactionDetail.bookingDate})
    }
    
    func getTransactionSum(_ transactions: [Item]) -> Int {
        return transactions.reduce(0) { partialResult, item in
            partialResult + item.transactionDetail.value.amount
        }
    }
    
    func getCategories(_ transactions: [Item]) -> [Int] {
        return Array(Set(transactions.map({ item in
            item.category
            
        }
                                         )
                        )
        ).sorted()
    }
    
    func filterByCategory(_ category: Int?) {
        if let category = category {
            shownTransactions = sortTransactions(transactions.filter({$0.category == category}))
        } else {
            shownTransactions = transactions
        }
        transactionsSum = getTransactionSum(shownTransactions)
    }
    
    private func delayMockError() async throws {
        try await Task.sleep(until: .now + .seconds(2), clock: .continuous)
        DispatchQueue.main.sync {
            hasMockTimeElapsed = true
        }
    }
}
