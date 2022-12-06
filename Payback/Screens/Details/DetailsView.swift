//
//  DetailsView.swift
//  Payback
//
//  Created by Emre Boyaci on 4.12.2022.
//

import SwiftUI

struct DetailsView: View {
    let transaction: Item
    
    init(_ transaction: Item) {
        self.transaction = transaction
    }
    var body: some View {
        VStack {
            Text(transaction.partnerDisplayName)
                .font(.largeTitle)
                .bold()
                .padding()
            Text(transaction.transactionDetail.description ?? "")
                .font(.title2)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(Item(partnerDisplayName: "REWE",
                                      alias: Alias(reference: "Reference"),
                                      category: 1,
                                      transactionDetail:
                                        TransactionDetail(description: "Transaction Detail",
                                                          bookingDate: Date.now,
                                                          value: Value(amount: 15, currency: "PBP"))))
    }
}
