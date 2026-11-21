import 'package:flutter/material.dart';

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
    required this.price,
    required this.category,
    required this.image,
    this.description = '',
    this.macros,
    this.calories,
    this.originalPrice,
    this.isPopular = false,
    this.isVegetarian = false,
    this.isSpicy = false,
    this.isCustomizable = false,
    this.imageBgColor = const Color(0xFF144B5B),
    this.optionGroups = const [],
  });

  final String id;
  final String name;
  final double price;
  final String category;
  final String image;
  final String description;
  final String? macros;
  final int? calories;
  final double? originalPrice;
  final bool isPopular;
  final bool isVegetarian;
  final bool isSpicy;
  final bool isCustomizable;
  final Color imageBgColor;
  final List<MenuItemOptionGroup> optionGroups;

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
    required this.actionText,
    this.isApplied = false,
    this.iconData = Icons.delivery_dining_rounded,
    this.iconColor = const Color(0xFFE84242),
    this.iconBgColor = const Color(0xFFFFECE5),
  });

  final String id;
  final String title;
  final String subtitle;
  final String actionText;
  final bool isApplied;
  final IconData iconData;
  final Color iconColor;
  final Color iconBgColor;
}

@immutable
class Store {
  const Store({
    required this.name,
    required this.tagline,
    required this.rating,
    required this.reviewCount,
    required this.ratingBadge,
    required this.deliveryMinutes,
    required this.deliveryFeeText,
    required this.deliveredBy,
    required this.freeDeliveryPromo,
    required this.address,
    required this.heroImage,
    required this.categories,
    required this.menuItems,
    required this.offers,
    this.cuisine = 'Arabic · Lebanese · Bakery',
    this.distanceKm = 2.4,
    this.pickupMinutes = '10-15 mins',
    this.openingHours = '7:00 AM – 1:00 AM Daily',
    this.hygieneScore = 'Grade A (Dubai Municipality)',
  });

  final String name;
  final String tagline;
  final double rating;
  final int reviewCount;
  final String ratingBadge;
  final String deliveryMinutes;
  final String deliveryFeeText;
  final String deliveredBy;
  final String freeDeliveryPromo;
  final String address;
  final String heroImage;
  final List<String> categories;
  final List<MenuItem> menuItems;
  final List<StoreOffer> offers;
  final String cuisine;
  final double distanceKm;
  final String pickupMinutes;
  final String openingHours;
  final String hygieneScore;
}
