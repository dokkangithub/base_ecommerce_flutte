# Flutter E-commerce App with Multi-Backend Support

![E-commerce App Banner](https://via.placeholder.com/800x200)

A robust, feature-rich e-commerce mobile application built with Flutter that supports both Laravel and WordPress backends through a clean, scalable architecture following SOLID principles.

## 📋 Features

- **Multi-Backend Support**: Seamlessly works with both Laravel and WordPress APIs
- **Clean Architecture**: Domain-driven design with clear separation of concerns
- **SOLID Principles**: Follows all SOLID design principles for maintainable code
- **BLoC Pattern**: Reactive state management using the BLoC pattern
- **Dependency Injection**: Service locator pattern for managing dependencies
- **Dynamic Configuration**: Backend selection through configuration file
- **Complete E-commerce Flow**: Authentication, product listing, cart management, checkout, and orders

## 🏗️ Architecture Overview

This application follows Clean Architecture with three main layers:

### 1. Domain Layer

Contains business logic and rules independent of any external framework:
- **Entities**: Core business objects (User, Product, Order)
- **Repositories**: Abstract interfaces defining data operations
- **Use Cases**: Application-specific business rules

### 2. Data Layer

Implements the data sources and repositories:
- **Models**: Data transfer objects for both Laravel and WordPress
- **Data Sources**: API clients for remote data
- **Repository Implementations**: Concrete implementations of domain repositories

### 3. Presentation Layer

User interface and state management:
- **BLoCs**: Business Logic Components handling state
- **Pages**: UI screens
- **Widgets**: Reusable UI components

## 📂 Project Structure

```
lib/
├── main.dart                  # Entry point with API selection
├── config/                    # App configuration
│   ├── app_config.dart        # Configuration model and loader
│   ├── routes.dart            # App routes
│   └── themes.dart            # App themes
├── core/                      # Core utilities and services
│   ├── api/                   # API providers
│   ├── errors/                # Error handling
│   ├── network/               # Network utilities
│   └── utils/                 # Helper utilities
├── data/                      # Data layer
│   ├── datasources/           # Remote data sources
│   │   ├── laravel/           # Laravel specific implementations
│   │   └── wordpress/         # WordPress specific implementations
│   ├── models/                # Data models
│   │   ├── laravel/           # Laravel specific models
│   │   └── wordpress/         # WordPress specific models
│   └── repositories/          # Repository implementations
├── domain/                    # Domain layer
│   ├── entities/              # Business entities
│   ├── repositories/          # Repository interfaces
│   └── usecases/              # Business use cases
└── presentation/              # Presentation layer
    ├── blocs/                 # BLoCs for state management
    ├── pages/                 # App screens
    └── widgets/               # Reusable UI components
```

## 🔄 API Switching Flow

The app dynamically selects the appropriate API provider based on configuration:

1. On app startup, `AppConfig` loads settings from `assets/config.json`
2. The appropriate API provider (Laravel or WordPress) is registered in the dependency injection container
3. Repository implementations use the registered API provider
4. Business logic remains consistent regardless of the backend

## 🛠️ Setup Instructions

### Prerequisites

- Flutter SDK 3.10.0 or higher
- Dart SDK 3.0.0 or higher
- An IDE (VS Code or Android Studio)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/flutter-ecommerce.git
   cd flutter-ecommerce
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure the backend:
   Create or modify `assets/config.json`:
   ```json
   {
     "app_name": "E-commerce App",
     "base_url": "https://your-api-url.com",
     "api_type": "laravel  or wordpress"
   }
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## 🚀 Deployment

### Android

```bash
flutter build apk --release
```

### iOS

```bash
flutter build ios --release
```

## 🧪 Testing

The project includes unit, widget, and integration tests:

```bash
# Run all tests
flutter test

# Run specific test
flutter test test/path/to/test_file.dart
```

## 🔄 API Documentation

### Laravel API Endpoints

- **Authentication**:
  - `POST /api/auth/login`: User login
  - `POST /api/auth/register`: User registration

- **Products**:
  - `GET /api/products`: List all products
  - `GET /api/products/{id}`: Get product details

- **Orders**:
  - `POST /api/orders`: Create order
  - `GET /api/orders`: List user orders

### WordPress API Endpoints

- **Authentication**:
  - `POST /wp-json/jwt-auth/v1/token`: User login
  - `POST /wp-json/wp/v2/users`: User registration

- **Products**:
  - `GET /wp-json/wc/v3/products`: List all products
  - `GET /wp-json/wc/v3/products/{id}`: Get product details

- **Orders**:
  - `POST /wp-json/wc/v3/orders`: Create order
  - `GET /wp-json/wc/v3/orders`: List user orders

## 📊 State Management

The app uses the BLoC pattern for state management:

1. **Events**: Triggered by user actions
2. **BLoCs**: Process events and emit states
3. **States**: Represent the UI state at a given moment
4. **UI**: Rebuilds based on state changes

Example flow for authentication:
- User enters credentials → `LoginEvent` fired → `AuthBloc` processes event → `AuthSuccessState` emitted → UI updates

## 🔌 Adding New Features

To add a new feature:

1. Define entities in the domain layer
2. Create repository interfaces in the domain layer
3. Implement use cases in the domain layer
4. Create models in the data layer for both Laravel and WordPress
5. Implement repository in the data layer
6. Create BLoC, events, and states in the presentation layer
7. Build UI components in the presentation layer

## 🧩 SOLID Principles Implementation

- **Single Responsibility**: Each class has a single responsibility
- **Open/Closed**: New backends can be added without modifying existing code
- **Liskov Substitution**: API providers are interchangeable
- **Interface Segregation**: Repositories define focused interfaces
- **Dependency Inversion**: High-level modules depend on abstractions

## 🔄 Continuous Integration

The project uses GitHub Actions for CI/CD:
- Automated testing on push
- Build validation
- Linting and static analysis

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👥 Contributors

- [Mohamed emad](https://github.com/MuhammedEmad5)

## 🙏 Acknowledgments

- Flutter Team for the amazing framework
- [GetIt](https://pub.dev/packages/get_it) for dependency injection
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) for state management
