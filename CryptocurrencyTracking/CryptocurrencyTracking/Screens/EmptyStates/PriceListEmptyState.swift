//
//  PriceListEmptyState.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 26/12/2024.
//

import SwiftUI

struct PriceListEmptyState: View {
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            
            VStack {
                Image(ImageNameConstants.priceListeEmptyState)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                
                Text("No cryptocurrency found.")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
            }

        }
        
    }
}

struct PriceListEmptyStatePreviews: PreviewProvider{
    
    static var previews: some View{
        PriceListEmptyState()
    }

}
