//
//  CeilingBanner.swift
//  Payback
//
//  Created by Emre Boyaci on 5.12.2022.
//

import SwiftUI

struct CeilingBanner: View {
    let type: BannerType
    
    init(_ type: BannerType = .noInternet) {
        self.type = type
    }
    
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(.red)
            VStack {
                Spacer()
                if type == .noInternet {
                    Text("No Internet Connection")
                        .bold()
                        .padding()
                } else {
                    Text("An Error Occurred")
                        .bold()
                        .padding()
                }
            }
            .transition(.slide)
            .frame(height: 100)
        }
        .frame(height: 100)
        .ignoresSafeArea()
    }
    
    public enum BannerType {
        case noInternet
        case error
    }
}

struct CeilingBanner_Previews: PreviewProvider {
    static var previews: some View {
        CeilingBanner(.noInternet)
    }
}
