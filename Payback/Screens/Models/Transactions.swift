import Foundation

// MARK: - Transactions
struct Transactions: Codable, Hashable {
    var items: [Item]
}

// MARK: - Item
struct Item: Codable, Hashable {
    let partnerDisplayName: String
    let alias: Alias
    let category: Int
    let transactionDetail: TransactionDetail
}

// MARK: - Alias
struct Alias: Codable, Hashable {
    let reference: String
}

// MARK: - TransactionDetail
struct TransactionDetail: Codable, Hashable {
    let description: String?
    let bookingDate: Date
    let value: Value
}

// MARK: - Value
struct Value: Codable, Hashable {
    let amount: Int
    let currency: String
}
