import 'package:flutter/foundation.dart';

@immutable
class MenuItemOption {
  const MenuItemOption({
    required this.name,
    this.price = 0.0,
    this.isDefault = false,
  });

  final String name;
  final double price;
  final bool isDefault;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuItemOption &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          price == other.price;

  @override
  int get hashCode => name.hashCode ^ price.hashCode;
}

@immutable
class MenuItemOptionGroup {
  const MenuItemOptionGroup({
    required this.title,
    required this.options,
    this.isRequired = false,
    this.maxSelections = 1,
  });

  final String title;
  final List<MenuItemOption> options;
  final bool isRequired;
  final int maxSelections;
}

@immutable
class MenuItem {
  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    this.originalPrice,
    this.isPopular = false,
    this.isVegetarian = false,
    this.isSpicy = false,
    this.calories,
    this.optionGroups = const [],
  });

  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final String category;
  final String image;
  final bool isPopular;
  final bool isVegetarian;
  final bool isSpicy;
  final int? calories;
  final List<MenuItemOptionGroup> optionGroups;

  bool get isCustomizable => optionGroups.isNotEmpty;
  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

@immutable
class CartItem {
  const CartItem({
    required this.item,
    this.quantity = 1,
    this.selectedOptions = const [],
    this.specialInstructions,
  });

  final MenuItem item;
  final int quantity;
  final List<MenuItemOption> selectedOptions;
  final String? specialInstructions;

  double get unitPrice {
    final optionsTotal = selectedOptions.fold<double>(
      0.0,
      (sum, opt) => sum + opt.price,
    );
    return item.price + optionsTotal;
  }

  double get totalPrice => unitPrice * quantity;

  CartItem copyWith({
    MenuItem? item,
    int? quantity,
    List<MenuItemOption>? selectedOptions,
    String? specialInstructions,
  }) {
    return CartItem(
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }
}

@immutable
class StoreOffer {
  const StoreOffer({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.code,
    required this.minSpend,
    required this.discountAmount,
  });

  final String id;
  final String title;
  final String subtitle;
  final String code;
  final double minSpend;
  final double discountAmount;
}

@immutable
class Store {
  const Store({
    required this.name,
    required this.tagline,
    required this.cuisine,
    required this.rating,
    required this.reviewCount,
    required this.deliveryMinutes,
    required this.pickupMinutes,
    required this.deliveryFee,
    required this.minimumOrder,
    required this.address,
    required this.distanceKm,
    required this.heroImage,
    required this.logoImage,
    required this.categories,
    required this.menuItems,
    required this.offers,
    this.openingHours = '10:00 AM – 1:00 AM',
    this.hygieneScore = 'Grade A (Dubai Municipality)',
  });

  final String name;
  final String tagline;
  final String cuisine;
  final double rating;
  final int reviewCount;
  final String deliveryMinutes;
  final String pickupMinutes;
  final double deliveryFee;
  final double minimumOrder;
  final String address;
  final double distanceKm;
  final String heroImage;
  final String logoImage;
  final List<String> categories;
  final List<MenuItem> menuItems;
  final List<StoreOffer> offers;
  final String openingHours;
  final String hygieneScore;
}
