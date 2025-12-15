# TZ Project

A Flutter application demonstrating Clean Architecture, State Management, and Local Storage.

## Features

- **Onboarding Flow**: Smooth onboarding experience for new users.
- **Paywall & Subscriptions**: 
  - Monthly and Yearly subscription options.
  - Local persistence of subscription status using Hive.
  - Discount calculation and "Best Value" highlighting.
- **Home Screen**: Accessible only after valid subscription.
- **Navigation**: Managed by GoRouter with redirect logic based on subscription status.

## Tech Stack

- **Flutter**: UI Framework.
- **Bloc/Cubit**: State Management.
- **Hive**: Local NoSQL Database for persistence.
- **GoRouter**: Declarative routing.
- **Clean Architecture**: Separation of concerns (Domain, Data, Presentation).

## Project Structure

```
lib/
├── core/               # Core configuration (Theme, Router, Constants)
├── data/               # Data layer (Repositories, Models, Data Sources)
├── domain/             # Domain layer (Entities, Repository Interfaces)
├── presentation/       # UI layer (Pages, Widgets)
│   └── pages/
│       ├── home/
│       ├── onboarding/
│       └── paywall/    # Includes Controller (Cubit)
└── main.dart           # Entry point
```

## Getting Started

1.  **Clone the repository**:
    ```bash
    git clone <repository-url>
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Run the app**:
    ```bash
    flutter run
    ```
