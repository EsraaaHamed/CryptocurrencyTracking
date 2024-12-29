//
//  CryptocurrencyListViewCell.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 24/12/2024.
//

import SwiftUI

struct CryptocurrencyListViewCell: View {
    @EnvironmentObject var favoriteCryptocurrencies: FavoriteCryptocurrencies
    
    let cryptocurrency: Cryptocurrency
    var body: some View {
        HStack {
            AsyncImage(url: cryptocurrency.image){ image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .cornerRadius(10)
                    .transition(.opacity)
            } placeholder: {
                Image(ImageNameConstants.coinCellPlaceholderImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .cornerRadius(10)
            }
            Text(cryptocurrency.name)
                .font(.title3)
                .bold()
                .minimumScaleFactor(0.5)
            
            Spacer()
            VStack(alignment: .trailing) {
                Text("$\(cryptocurrency.currentPrice, specifier: "%.2f")")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .minimumScaleFactor(0.5)
            }
            
            Image(favoriteCryptocurrencies.contains(cryptocurrency: cryptocurrency) ? ImageNameConstants.favoriteImageName : ImageNameConstants.unfavoriteImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .onTapGesture {
                    withAnimation {
                        favoriteCryptocurrencies.toggleFav(cryptocurrency: cryptocurrency)
                    }
                }
            
        }.padding([.leading, .trailing], 5)
            .padding([.top, .bottom], 15)
        
        
    }
}

//struct CryptocurrencyListViewCell_Previews: PreviewProvider {
//    static var previews: some View { CryptocurrencyListViewCell(cryptocurrency: CryptocurrencyMockedData.cryptocurrencyMockedData).environmentObject(FavoriteCryptocurrencies())
//    }
//}
