# SuperPay

SuperPay is a modern SwiftUI-based mini shopping cart and payment demo app, designed to showcase best practices in architecture, modularity, and testability for iOS development. It features a product list, cart management, wallet integration, and a simulated checkout flow, all built with clean separation of concerns and robust error handling.In this project I dont give much focus on UI/UX design as the main aim of this project is to showcase architecture, modularity, and testability. I have used basic SwiftUI components to keep the UI simple and functional and avoid 3rd party libraries to keep the project lightweight and focused on native Swift and SwiftUI capabilities.

## Features
- Product listing with async image loading and caching
- Add/remove products to/from cart
- Cart management with total calculation
- Wallet balance display and deduction on payment
- Simulated checkout with random success/failure and alert feedback
- Pull-to-refresh for product list
- Accessibility and UI testing support
- Persistent cart and wallet state using UserDefaults

## Architecture
SuperPay follows a modular MVVM (Model-View-ViewModel) architecture with protocol-oriented design and SOLID principles.
## Reson for selecting this architecture:
- **MVVM**: Provides separation of concerns, testability, and SwiftUI compatibility.It supports scalability, SOLID principles, mocking, dependency injection, and maintainability. Allows for clear separation between UI and business logic. Also this project is a simple and small project so MVVM is a good fit.

## Modules
- **ProductList**: Displays products, handles image loading, and add-to-cart actions
- **Cart**: Manages cart items, removal, total calculation, and wallet integration
- **Checkout**: Handles payment logic, result alerts, and wallet deduction
- **Wallet**: Displays wallet balance and manages persistence
- **Services**: Provides data access and business logic (ProductService, CartPersistenceService, CheckoutService, WalletPersistenceService)

## Key Components
- **Models**: `Product`, `CartItem`, `Wallet`, `CheckoutResult` (all Codable, Identifiable)
- **ViewModels**: Each feature has a dedicated view model conforming to a protocol for testability and abstraction
- **Views**: SwiftUI views are stateless and bind to ObservableObject view models
- **Protocols**: All services and view models use protocols for dependency injection and mocking
- **Persistence**: Cart and wallet state are saved/loaded using UserDefaults via dedicated services
- **Async/Await**: Product and checkout services support both completion handler and async/await APIs
- **Image Caching**: Images are loaded and cached in the background for performance

## Testing
- **Unit Tests**: Separated by business logic and view model (ProductModelTests, CartModelTests, WalletModelTests, ProductServiceTests, CheckoutServiceTests, CartViewModelTests, CheckoutViewModelTests, WalletViewModelTests)
- **UI Tests**: Organized by major flows (ProductListUITests, CartUITests, CheckoutUITests, WalletUITests)
- **Setup/TearDown**: All tests use proper setup and teardown for clean state
- **Robust Assertions**: UI tests use flexible predicates and timeouts for dynamic labels

## Specifications
- Swift 5.9+ / SwiftUI 4+
- MVVM architecture, protocol-oriented, SOLID principles
- Dependency injection for all services and view models
- Accessibility identifiers for UI testing
- Persistent state for cart and wallet
- Async image loading and caching
- Simulated network calls for product fetch and checkout
- Error handling and user feedback via alerts
- Modular folder structure for easy navigation and maintenance

## Folder Structure
```
SuperPay/
├── Features/
│   ├── ProductList/
│   ├── Cart/
│   ├── Checkout/
│   └── Resources/
├── Services/
├── SuperPayApp.swift
├── products.json
├── SuperPayTests/
└── SuperPayUITests/
```

## How to Run
1. Open `SuperPay.xcodeproj` in Xcode 15+
2. Build and run the app on iOS Simulator or device
3. Run unit and UI tests using Cmd+U

## Extensibility
- Add new products by editing `products.json`
- Add new features by creating new modules and protocols
- Easily mock services for testing and demo purposes

## License
This project is for demo purposes only.
