import '../data/store_models.dart';

sealed class StoreEvent {
  const StoreEvent();
}

class StoreCategorySelected extends StoreEvent {
  const StoreCategorySelected(this.category);

  final String category;
}

class StoreSearchChanged extends StoreEvent {
  const StoreSearchChanged(this.query);

  final String query;
}

class StoreFavoriteToggled extends StoreEvent {
  const StoreFavoriteToggled();
}

class StoreDeliveryModeToggled extends StoreEvent {
  const StoreDeliveryModeToggled({required this.isDelivery});

  final bool isDelivery;
}

class StoreItemAdded extends StoreEvent {
  const StoreItemAdded(this.itemId);

  final String itemId;
}

class StoreItemRemoved extends StoreEvent {
  const StoreItemRemoved(this.itemId);

  final String itemId;
}

class StoreCustomItemAdded extends StoreEvent {
  const StoreCustomItemAdded({
    required this.item,
    required this.quantity,
    this.selectedOptions = const [],
    this.specialInstructions,
  });

  final MenuItem item;
  final int quantity;
  final List<MenuItemOption> selectedOptions;
  final String? specialInstructions;
}

class StoreCartCleared extends StoreEvent {
  const StoreCartCleared();
}
