# CryptocurrencyTracking
Cryptocurrency Tracking App
This app is for tracking real-time prices, manage their favorites, and navigate to a details screen for each cryptocurrency

## Table of Contents
1. [Features](#features)
2. [Installation](#installation)
3. [Architecture](#Architecture)


## Features
- Real-Time Prices: Stay updated with the latest cryptocurrency prices, with auto-refresh every 30 seconds.
- Search Cryptocurrencies: Quickly find any cryptocurrency by name or symbol.
- Favorites Management: Save and organize your favorite cryptocurrencies for easy access.
- Details Screen: Navigate to a detailed view of each selected currency.
- Error Handling: Provides user-friendly error messages for API errors.

## Installation
1. Clone the repository:
   ```
   git clone https://github.com/EsraaaHamed/CryptocurrencyTracking.git
   ```
2. Navigate to the project directory:
   ```
   cd CryptocurrencyTracking
   ```
## Architecture

1. this project follows the MVVM (Model-View-ViewModel) architecture pattern, which ensures a clean separation of concerns and improves code maintainability.

MVVM Components in the Project:
- Model:
Responsible for managing the application's data.
Located in the /Models directory.

- View:
Represents the UI layer and displays data from the ViewModel.
Reacts to user interactions and binds to the ViewModel for updates.
Found in /Screens directory, named as <ScreenName>View.

- ViewModel:
Acts as a bridge between the Model and View.
Provides data to the View in a format that it can easily consume.
Observes changes in the Model and updates the View accordingly.
Found in the /Screens directory, named as <ScreenName>ViewModel.

2. Additional Components:

Utils:
- Contains shared utilities or helper functions.
- Includes managers like the network manager and caching manager.

Assets: 
- Stores static resources such as images and styles.

 
