//
//  TransactionSumView.swift
//  Payback
//
//  Created by Emre Boyaci on 4.12.2022.
//

import SwiftUI

struct TransactionSumView: View {
    @Binding var summation: Int
    @Binding var isCollapsed: Bool
    @StateObject var model = TransactionSumViewModel()
    
    init(summation: Binding<Int>, isSumViewCollapsed: Binding<Bool>) {
        self._summation = summation
        self._isCollapsed = isSumViewCollapsed
    }
    
    var body: some View {
        if !model.isCollapsed {
            VStack(alignment: .center) {
                items
            }
            .transition(.push(from: .bottom))
        } else {
            HStack(alignment: .center) {
                items
            }
            .transition(.push(from: .top))
        }
    }
    
    @ViewBuilder var items: some View {
        Text("Transaction Sum")
            .font(.callout)
            .bold()
            .frame(alignment: .center)
            .onAppear {
                model.updateSummation(summation)
            }
            .onChange(of: isCollapsed) { newValue in
                withAnimation(.easeInOut(duration: 0.15)) {
                    model.toggleCurrentState(newValue)
                }
            }
            .onChange(of: summation) { newValue in
                withAnimation(.easeInOut(duration: 0.1)) {
                    model.updateSummation(summation)
                }
            }
        
        Text("\(model.summation)")
            .font(model.isCollapsed ? .title2 : .largeTitle)
            .bold()
            .frame(alignment: .center)
            .padding(model.isCollapsed ? .leading : .top, 1.0)
    }
}

struct TransactionSumView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionSumView(summation: .constant(15), isSumViewCollapsed: .constant(false))
    }
}
