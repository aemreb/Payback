//
//  PaybackApp.swift
//  Payback
//
//  Created by Emre Boyaci on 3.12.2022.
//

import SwiftUI

@main
struct PaybackApp: App {
    @ObservedObject var networkCheck = NetworkReachability()
    
    var body: some Scene {
        WindowGroup {
            HomeView(isNetworkConnected: $networkCheck.isConnected)
                .animation(.easeInOut(duration: 0.2), value: networkCheck.isConnected)
        }
    }
}
