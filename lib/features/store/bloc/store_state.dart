import '../data/store_models.dart';

enum StoreStatus { initial, loading, loaded, error }

class StoreState {
  const StoreState({
    required this.store,
    this.status = StoreStatus.loaded,
    this.selectedCategory = 'Picks for you 🔥',
    this.searchQuery = '',
    this.isFavorite = false,
    this.isDelivery = true,
    this.cartItems = const [],
    this.cartQuantities = const {},
  });

  final Store store;
  final StoreStatus status;
  final String selectedCategory;
  final String searchQuery;
  final bool isFavorite;
  final bool isDelivery;
  final List<CartItem> cartItems;
  final Map<String, int> cartQuantities;

  List<MenuItem> get visibleItems {
    final query = searchQuery.trim().toLowerCase();
    return store.menuItems.where((item) {
      final matchesCategory = selectedCategory == 'Picks for you 🔥'
          ? (item.category == 'Picks for you 🔥' || item.isPopular)
          : item.category.toLowerCase() == selectedCategory.toLowerCase();
      final matchesSearch = query.isEmpty ||
          item.name.toLowerCase().contains(query) ||
          item.description.toLowerCase().contains(query) ||
          item.category.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  int get cartItemCount =>
      cartQuantities.values.fold(0, (total, quantity) => total + quantity);

  double get subtotal {
    if (cartItems.isNotEmpty) {
      return cartItems.fold<double>(0.0, (sum, item) => sum + item.totalPrice);
    }
    return store.menuItems.fold<double>(0.0, (total, item) {
      return total + item.price * (cartQuantities[item.id] ?? 0);
    });
  }

  // Alias for backward compatibility with existing tests
  double get cartTotal => subtotal;

  double get activeDeliveryFee {
    if (!isDelivery || cartItemCount == 0) return 0.0;
    return 0.0; // Free delivery in reference
  }

  double get discountAmount => 0.0;

  double get vatAmount {
    if (cartItemCount == 0) return 0.0;
    return subtotal * 0.05; // 5% UAE VAT
  }

  double get grandTotal {
    if (cartItemCount == 0) return 0.0;
    return subtotal + activeDeliveryFee + vatAmount - discountAmount;
  }

  int getItemQuantity(String itemId) => cartQuantities[itemId] ?? 0;

  StoreState copyWith({
    Store? store,
    StoreStatus? status,
    String? selectedCategory,
    String? searchQuery,
    bool? isFavorite,
    bool? isDelivery,
    List<CartItem>? cartItems,
    Map<String, int>? cartQuantities,
  }) {
    return StoreState(
      store: store ?? this.store,
      status: status ?? this.status,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      isFavorite: isFavorite ?? this.isFavorite,
      isDelivery: isDelivery ?? this.isDelivery,
      cartItems: cartItems ?? this.cartItems,
      cartQuantities: cartQuantities ?? this.cartQuantities,
    );
  }
}
