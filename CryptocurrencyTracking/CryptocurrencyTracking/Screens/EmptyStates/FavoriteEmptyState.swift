//
//  FavoriteEmptyState.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 26/12/2024.
//
import SwiftUI

struct FavoriteEmptyState: View {
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            
            VStack {
                Image(ImageNameConstants.favoriteImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                
                Text("There is not favorite currency added yet.")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
            }

        }
        
    }
}

struct FavoriteEmptyStatePreviews: PreviewProvider{
    
    static var previews: some View{
        FavoriteEmptyState()
    }

}
