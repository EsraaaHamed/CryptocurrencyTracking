//
//  CryptocurrencyDetailsView.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 22/12/2024.
//

import SwiftUI

struct CryptocurrencyDetailsView<Model>: View where Model: CryptocurrencyDetailsViewModelProtocol {
    @StateObject var cryptocurrencyDetailsVM : Model
    init(cryptocurrencyDetailsVM: Model) {
        _cryptocurrencyDetailsVM = StateObject(wrappedValue: cryptocurrencyDetailsVM)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                
                HStack {
                    Text(cryptocurrencyDetailsVM.cryptocurrency.name)
                        .font(.largeTitle)
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text(cryptocurrencyDetailsVM.cryptocurrency.symbol.capitalized)
                        .font(.title)
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(.secondary)
                }.padding(20)
                
                
                if let coinImage = cryptocurrencyDetailsVM.loadedImage {
                    Image(uiImage: coinImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                }
                
                Text("Overview:")
                    .font(.title)
                    .bold()
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Current Price:")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.secondary)
                            .padding([.top, .bottom], 15)
                        
                        
                        Text("$"+String(cryptocurrencyDetailsVM.cryptocurrency.currentPrice))
                            .font(.title3)
                            .bold()
                            .foregroundColor(.green)
                        
                        
                    }.padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(.white)
                        .clipped()
                        .shadow(color: Color.gray, radius: 7, x: 0, y: 0)
                    
                    VStack {
                        Text("Change Percentage:")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.secondary)
                            .padding([.top, .bottom], 15)
                        
                        Text(String(cryptocurrencyDetailsVM.cryptocurrency.priceChangePercentage24h ?? 0)+"%")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.green)
                        
                        
                    }.padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(.white)
                        .clipped()
                        .shadow(color: Color.gray, radius: 7, x: 0, y: 0)
                }.padding()
                
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            
                .task() {
                    cryptocurrencyDetailsVM.getCoinImage()
                    
                }
        }
    }
}
