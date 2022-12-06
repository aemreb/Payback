//
//  ErrorView.swift
//  Payback
//
//  Created by Emre Boyaci on 6.12.2022.
//

import SwiftUI

struct ErrorView: View {
    let retryAction: (() -> Void)?
    
    var body: some View {
        VStack {
            CeilingBanner(.error)
                .transition(.move(edge: .top))
            Spacer()
            Image("human")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.red)
                .frame(width: 100, height: 100)
            Text("Error Occured")
                .bold()
                .padding()
            Button("Retry?") {
                if let retryAction = retryAction {
                    retryAction()
                }
            }
            Spacer()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(retryAction: nil)
    }
}
