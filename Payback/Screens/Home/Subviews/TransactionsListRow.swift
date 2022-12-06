//
//  TransactionsListRow.swift
//  Payback
//
//  Created by Emre Boyaci on 5.12.2022.
//

import SwiftUI

struct TransactionsListRow: View {
    var transaction: Item
    
    var body: some View {
        VStack (alignment: .leading){
            Text(transaction.transactionDetail.bookingDate.formatted())
                .frame(alignment: .leading)
            Text(transaction.partnerDisplayName)
                .bold()
                .frame(alignment: .leading)
            Text(transaction.transactionDetail.description ?? "")
                .frame(alignment: .leading)
            Text("\(transaction.transactionDetail.value.amount) \(transaction.transactionDetail.value.currency)")
                .frame(alignment: .leading)
        }
    }
}

struct TransactionsListRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsListRow(transaction: Item(partnerDisplayName: "REWE",
                                              alias: Alias(reference: "Reference"),
                                              category: 1,
                                              transactionDetail:
                                                TransactionDetail(description: "Transaction Detail",
                                                                  bookingDate: Date.now,
                                                                  value: Value(amount: 15, currency: "PBP"))))
    }
}
