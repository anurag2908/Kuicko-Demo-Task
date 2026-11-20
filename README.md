# Kuicko · Flutter Restaurant/Store Detail Screen

Production-grade Flutter implementation of a Restaurant/Store Detail Screen inspired by **Talabat UAE (Dubai)** food delivery experience, built for the **Kuicko Flutter Developer** evaluation task.

Built using **BLoC (Business Logic Component)** state management, feature-first clean architecture, responsive sliver animations, and modular reusable widgets.

---

## 📱 Features & Highlights

- **Hero Collapsible Header (`StoreSliverHeader`)**:
  - Smooth parallax collapsing `SliverAppBar` transitioning from cover imagery to a pinned, branded top app bar.
  - Interactive top actions: Back navigation, Search trigger, Share to clipboard, and Animated Favorite Heart toggle.
  - Top Rated Dubai badge overlay.

- **Store Information & Ratings (`StoreInfoCard` & `StoreInfoSheet`)**:
  - Restaurant logo badge, name, and cuisine tags.
  - Key order metrics: Rating (`4.8 ★ / 2.4k+ reviews`), Delivery Time (`25–35 min`), Delivery Fee (`AED 5`), and Minimum Order (`AED 20`).
  - Modal bottom sheet displaying detailed store information, operating hours (`11:00 AM – 2:00 AM`), and Dubai Municipality Grade A hygiene score.

- **Order Mode Switcher (`DeliveryModeSwitch`)**:
  - Seamless toggle between **Delivery** (`25–35 min`) and **Pick-up** (`10–15 min`) with live price calculation adjustments.

- **Promotions & Deals Carousel (`PromotionsCarousel`)**:
  - Horizontal promotional vouchers (e.g. `LUCA15` for AED 15 OFF, `FREEDEL` for Free Delivery).
  - Tap-to-apply coupon code with instant visual feedback.

- **Sticky Category & Search Navigation (`CategoryStickyTabBar`)**:
  - Pinned `SliverPersistentHeader` category tab bar that sticks smoothly to the top as the user scrolls through the menu.
  - Real-time search filtering across dish titles, descriptions, and categories.
  - Responsive empty state with a "Reset Filters" action when no items match.

- **Menu Items & Dietary Badges (`MenuItemTile`)**:
  - Comprehensive item cards featuring food photography, descriptions, AED pricing, and strikethrough discount pricing.
  - Visual indicators: Vegetarian (Green dot), Spicy (Hot chili), and Bestseller (Flame badge).
  - Quick "+ ADD" button and increment/decrement counter.

- **Item Customization Bottom Sheet (`ItemCustomizationSheet`)**:
  - Talabat-style customization flow for dishes: choose bun type, select optional toppings and sauces, add special cooking instructions, and view real-time price updates before adding to cart.

- **Cart Summary & Floating Basket (`BasketBottomBar` & `CartSummarySheet`)**:
  - Animated floating bottom basket bar showing active item count and AED total.
  - Full basket review sheet with itemized breakdown, quantity modifiers, subtotal, delivery fee, 5% UAE VAT, coupon discounts, delivery address confirmation, and checkout action.

---

## 🏗 Architecture & Code Structure

The project follows a **Feature-Driven Architecture** with strict separation of concerns:

```
lib/
├── features/
│   └── store/
│       ├── bloc/
│       │   ├── store_bloc.dart       # BLoC handling business logic & cart state
│       │   ├── store_event.dart      # Sealed events for user interactions
│       │   └── store_state.dart      # Immutable state with computed getters
│       ├── data/
│       │   ├── sample_store.dart     # Dubai store mock data & menu items
│       │   └── store_models.dart     # Data models (Store, MenuItem, CartItem, etc.)
│       └── presentation/
│           ├── store_detail_screen.dart # Main screen with CustomScrollView & Slivers
│           └── widgets/
│               ├── basket_bottom_bar.dart
│               ├── cart_summary_sheet.dart
│               ├── category_sticky_tab_bar.dart
│               ├── delivery_mode_switch.dart
│               ├── item_customization_sheet.dart
│               ├── menu_item_tile.dart
│               ├── promotions_carousel.dart
│               ├── store_info_card.dart
│               ├── store_info_sheet.dart
│               └── store_sliver_header.dart
└── main.dart
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `^3.13.7` or higher
- Dart SDK `^3.1.0` or higher

### Install Dependencies
```bash
flutter pub get
```

### Run Application
```bash
flutter run
```

### Run Tests
```bash
flutter test
```

### Run Code Linter
```bash
flutter analyze
```

---

## 🧪 Testing & Quality Assurance

Unit and widget tests cover:
- Store loading and data rendering
- Cart increment, decrement, and item removal
- Category tab switching and filtering
- Live search queries and item visibility
- Clean code passing all Flutter linter rules (`flutter analyze`)
