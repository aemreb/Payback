//
//  ContentView.swift
//  Payback
//
//  Created by Emre Boyaci on 3.12.2022.
//

import SwiftUI

struct HomeView: View {
    @Binding var isNetworkConnected: Bool
    @StateObject var model: HomeViewModel = HomeViewModel()
    
    init(isNetworkConnected: Binding<Bool>) {
        self._isNetworkConnected = isNetworkConnected
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // connection error
                if !isNetworkConnected {
                    CeilingBanner()
                        .transition(.move(edge: .top))
                    listView
                // mock error
                } else if model.errorOccurred {
                    if model.hasMockTimeElapsed {
                        ErrorView(retryAction: {
                            model.tryLoading()
                        })
                    } else {
                        ZStack {
                            Color.pink.opacity(0.2).ignoresSafeArea()
                            ProgressView()
                        }.ignoresSafeArea()
                    }
                // no problem
                } else {
                    listView
                }
            }
            .background(Color.pink.opacity(0.2))
            .ignoresSafeArea()
        }
    }
    
    var filterMenu: some View {
        Menu{
            ForEach(0..<model.categories.count, id: \.self){index in
                Button(action: {
                    if model.selectedCategory != model.categories[index] {
                        model.selectedCategory = model.categories[index]
                        model.filterByCategory(model.selectedCategory)
                    } else {
                        model.selectedCategory = nil
                        model.filterByCategory(nil)
                    }
                }, label: {
                    HStack{
                        Text("\(model.categories[index])")
                        if model.selectedCategory == model.categories[index]{
                            Image(systemName: "checkmark")
                        }
                    }
                })
            }
        } label: {
            Button("\(Image(systemName: "line.3.horizontal.decrease.circle"))", action: {
            })
            .font(.title)
            .padding(.trailing)
            .foregroundColor(.blue)
            .frame(alignment: .center)
        }
    }
    
    var listView: some View {
        VStack {
            HStack (alignment: .center){
                //correct hstack placement
                Button("\(Image(systemName: "line.3.horizontal.decrease.circle"))", action: {
                    
                })
                .font(.title)
                .padding(.leading)
                .foregroundColor(.clear)
                Spacer()
                TransactionSumView(summation: $model.transactionsSum, isSumViewCollapsed: $model.isSumViewCollapsed)
                Spacer()
                filterMenu
            }
            .padding(.top, isNetworkConnected ? 70.0 : 10.0)
            
            List {
                ForEach(model.shownTransactions, id: \.self) { transaction in
                    NavigationLink {
                        DetailsView(transaction)
                    } label: {
                        TransactionsListRow(transaction: transaction)
                    }
                }
            }.gesture(
                DragGesture().onChanged { value in
                    if value.translation.height > 0 {
                        model.isSumViewCollapsed = false
                    } else {
                        model.isSumViewCollapsed = true
                    }
                }
            )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(isNetworkConnected: .constant(true))
    }
}
