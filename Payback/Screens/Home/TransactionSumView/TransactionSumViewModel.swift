//
//  TransactionSumViewModel.swift
//  Payback
//
//  Created by Emre Boyaci on 4.12.2022.
//

import Foundation
import SwiftUI

class TransactionSumViewModel: ObservableObject {
    @Published var summation: Int
    @Published var isCollapsed: Bool

    init(summation: Int = 0) {
        self.summation = summation
        self.isCollapsed = false
    }
    
    func updateSummation(_ summation: Int) {
        self.summation = summation
    }
    
    func toggleCurrentState(_ state: Bool? = nil) {
        if let state = state {
            self.isCollapsed = state
        } else {
            isCollapsed.toggle()
        }
    }
}
