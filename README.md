# inovola

A lightweight Flutter expense tracking mobile application with currency conversion, pagination, and offline support.

##  Architecture Overview

This application follows a clean architecture pattern with the BLoC (Business Logic Component) state management approach:

### Project Structure
```
lib/
├── custom_widgets/
├── core/
├── utils/
│   ├── database/          
│   └── network/           
├── features/
│   ├── dashboard/
│   │   ├── presentation/
│   │   │   ├── bloc/       
│   │   │   ├── pages/      
│   │   │   └── widgets/   
│   ├── expense/
│   │   ├── data/
│   │   │   └── models/     
│   │   └── presentation/
│   │       ├── bloc/      
│   │       └── pages/      
│   └── currency/
│       └── presentation/
│           └── bloc/       
└── main.dart
```

##  State Management Approach

### BLoC Pattern Implementation
- **DashboardBloc**: Manages dashboard state, expense list, pagination, and filtering
- **ExpenseBloc**: Handles expense creation, receipt upload, and form validation
- **CurrencyBloc**: Manages currency loading and selection

### State Flow
1. **Events** are dispatched from UI components
2. **BLoC** processes events and emits new **States**
3. **UI** reacts to state changes using `BlocBuilder` and `BlocListener`

##  API Integration

### Currency Conversion
- **API Used**: ExchangeRate-API (https://v6.exchangerate-api.com/)
- **Implementation**: Real-time currency conversion with fallback support
- **Error Handling**: Graceful fallback to default currencies if API fails
- **Caching**: Exchange rates are fetched per transaction

### API Client Features
- Built with **Dio** for robust HTTP requests
- Automatic timeout handling (10 seconds)
- Error handling and retry logic
- Support for different base currencies

##  Pagination Strategy

### Local Database Pagination
- **Implementation**: SQLite with LIMIT/OFFSET queries
- **Page Size**: 10 items per page
- **Strategy**: Infinite scroll with "Load More" functionality
- **Filtering**: Pagination works seamlessly with date filters
- **Performance**: Optimized queries with proper indexing

### Pagination Features
- Loading states for smooth UX
- Error handling for failed loads
- Support for filtered pagination
- Memory efficient scrolling

##  Local Storage

### Database Schema
```sql
CREATE TABLE expenses(
id INTEGER PRIMARY KEY AUTOINCREMENT,
category TEXT NOT NULL,
amount REAL NOT NULL,           -- Converted to USD
originalAmount REAL NOT NULL,   -- Original amount in selected currency
currency TEXT NOT NULL,         -- Original currency
date TEXT NOT NULL,
receiptPath TEXT,              -- Local file path for receipt
createdAt TEXT NOT NULL
);
```

### Storage Features
- **SQLite** for structured data storage
- **File System** for receipt images
- **Offline Support**: Full functionality without internet
- **Data Persistence**: All data survives app restarts


## Testing

### Test Files
- `test/expense_bloc_test.dart`: BLoC logic testing
- `test/widget_test.dart`: UI component testing

## Getting Started

### Prerequisites
- Flutter 3.32.3 

### Installation
1. Clone the repository:
```bash
git clone https://github.com/Ahmed-minyo/inovola.git
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```



### Bonus Features
**Pull-to-refresh ** on Dashboard
**Transition Animations
**Export CSV & PDF 



##  Technical Decisions & Trade-offs

### Architecture Decisions
- **BLoC Pattern**: Chosen for predictable state management and testability
- **SQLite**: Selected for robust local storage with complex queries
- **Dio**: Used for advanced HTTP features and error handling


### Assumptions Made
- Users primarily track expenses in USD (base currency)
- Receipt photos are optional but encouraged
- Monthly view is the default filter
- Mock income data (could be made configurable)



- ### UI ScreenShots
https://postimg.cc/gallery/fhVk6N3
- ** See All Button Opens the dialog for exporting CSV & PDF (Bonus)

### Running Tests

```
# Unit and widget tests
flutter test
```

### Code Generation
```
# Generate mocks for testing
flutter dart pub run build_runner build
```

