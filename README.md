# News Home SwiftUI App

This SwiftUI app fetches news articles from the *Wall Street Journal* (wsj.com) using the **NewsAPI**. It supports pagination and securely manages API keys using the Keychain, ensuring a safe and efficient network request process.

## Features

- Fetches news articles from *wsj.com* sorted by publication date.
- Pagination support to load more articles.
- Secure API key storage and retrieval from Keychain.
- Displays articles in a user-friendly list interface.
- Handles loading state, error messages, and retry attempts with Alamofire.
- 
## Project Structure

### `HomeView.swift`
Contains the main UI for displaying the news articles and handles interaction with the `NewsHomeViewModel`.

### `NewsHomeViewModel.swift`
Defines the ViewModel that interacts with the API, fetches news data, and publishes results to the UI. It uses **Alamofire** for network requests.

### `APIKeyManager.swift`
Manages the API key retrieval from secure storage (Keychain) using the `SecureStorage` class.

### `SecureStorage.swift`
Handles secure storage operations for saving and retrieving the API key using **Keychain**.

### `NetworkInterceptor.swift`
A custom interceptor to add the API key to every network request and retry requests in case of authorization failure.

## Setup

1. **Install Alamofire**:
   This project uses Alamofire for networking. Make sure to include it in your `Podfile` or `Package.swift`:

   **CocoaPods:**
   ```bash
   pod 'Alamofire'
   ```

   **Swift Package Manager:**
   ```bash
   https://github.com/Alamofire/Alamofire.git
   ```

2. **API Key**:
   Obtain an API key from [NewsAPI](https://newsapi.org/). You can add the API key to the Keychain using the `SecureStorage.saveToKeyChain()` method.

3. **Run the App**:
   Once the API key is saved, run the app. It will display news articles in a list, with the ability to load more articles when you click on load more button.

## Usage

- The app automatically fetches news articles from the Wall Street Journal.
- The `loadNews()` function is called to retrieve articles, appending the results to the existing list of articles while respecting pagination.
- Errors are handled gracefully, and if an error occurs, an alert is shown to the user.

## Security

- The API key is securely stored in the **Keychain** using the `SecureStorage` class to prevent unauthorized access.
- The `NetworkInterceptor` ensures the API key is added to the header of every network request.

## Error Handling

- If an error occurs during the network request, a message is displayed to the user via an alert.
- The `retry` functionality in `NetworkInterceptor` automatically retries failed requests with a 1-second delay in case of 401 Unauthorized errors.
