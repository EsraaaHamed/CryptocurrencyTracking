//
//  CryptocurrencyPricelistView.swift
//  CryptocurrencyTracking
//
//  Created by Israa hamed on 22/12/2024.
//

import SwiftUI

struct CryptocurrencyPricelistView<Model>: View where Model: CryptocurrencyPricelistViewModelProtocol{
    
    @ObservedObject var cryptocurrencyPricelistVM: Model
    
    init(viewModel: Model) {
        _cryptocurrencyPricelistVM = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        ZStack {
            NavigationStack {
                
                if cryptocurrencyPricelistVM.isloading  {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                        .padding()
                }else if cryptocurrencyPricelistVM.cryptoCurrencyPricelist.isEmpty {
                    PriceListEmptyState()
                } else {
                    VStack {
                        HStack {
                            Text("Coin")
                                .frame(maxWidth: .infinity, alignment: .leading).bold()
                            Text("Price")
                                .frame(maxWidth: .infinity, alignment: .trailing).bold()
                                .padding([.trailing], 40)
                        }.listRowSeparator(.hidden)
                            .padding([.leading, .trailing], 60)
                            .padding([.top, .bottom], 5)
                        List{
                            ForEach(cryptocurrencyPricelistVM.cryptoCurrencyPricelist, id: \.id) { cryptocurrencyItem in
                                NavigationLink(destination: CryptocurrencyDetailsView(cryptocurrencyDetailsVM: CryptocurrencyPricelistNavigationManager.getDetailsScreenVM(cryptocurrency: cryptocurrencyItem))) {
                                    CryptocurrencyListViewCell(cryptocurrency: cryptocurrencyItem).listRowSeparator(.hidden)
                                }
                            }
                            
                        }.navigationTitle("Pricelist")
                            .listStyle(.plain)
                    }
                }
            }.searchable(text: $cryptocurrencyPricelistVM.searchText, prompt: "search by name or symbol")
        }.onAppear() {
            cryptocurrencyPricelistVM.getCryptocurrencyPricelist()
            cryptocurrencyPricelistVM.startAutoRefresh()
        }.onDisappear() {
            cryptocurrencyPricelistVM.stopAutoRefresh()
        }.alert(item: $cryptocurrencyPricelistVM.errorAlert) { error in
            Alert(title: Text("Error").foregroundColor(.red), message: Text("\(error.apiError.rawValue)"), dismissButton: Alert.Button.default(Text("OK")))
        }
        
    }
}

struct CryptocurrencyPricelistView_Previews: PreviewProvider {
    static var previews: some View {
        CryptocurrencyPricelistView(viewModel: CryptocurrencyPricelistViewModel(networkManager: NetworkManager()))
    }
}

