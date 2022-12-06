//
//  NetworkReachability.swift
//  Payback
//
//  Created by Emre Boyaci on 5.12.2022.
//

import Foundation
import Network

class NetworkReachability: ObservableObject {
    @Published var isConnected: Bool = true
    private var monitor: NWPathMonitor
    
    init() {
        monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self.isConnected = true
                } else {
                    self.isConnected = false
                }
            }
        }
        
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
    
    public func cancelNetworkMonitor() {
        monitor.cancel()
    }
}
