import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/store_models.dart';
import 'store_event.dart';
import 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc({required Store store}) : super(StoreState(store: store)) {
    on<StoreCategorySelected>((event, emit) {
      emit(state.copyWith(selectedCategory: event.category));
    });

    on<StoreSearchChanged>((event, emit) {
      emit(state.copyWith(searchQuery: event.query));
    });

    on<StoreFavoriteToggled>((event, emit) {
      emit(state.copyWith(isFavorite: !state.isFavorite));
    });

    on<StoreDeliveryModeToggled>((event, emit) {
      emit(state.copyWith(isDelivery: event.isDelivery));
    });

    on<StoreItemAdded>((event, emit) {
      final menuItem = state.store.menuItems.firstWhere(
        (i) => i.id == event.itemId,
        orElse: () => state.store.menuItems.first,
      );

      final nextQuantities = Map<String, int>.of(state.cartQuantities);
      nextQuantities.update(
        event.itemId,
        (quantity) => quantity + 1,
        ifAbsent: () => 1,
      );

      final nextCartItems = List<CartItem>.from(state.cartItems);
      final existingIndex = nextCartItems.indexWhere(
        (ci) => ci.item.id == event.itemId && ci.selectedOptions.isEmpty,
      );

      if (existingIndex >= 0) {
        final existing = nextCartItems[existingIndex];
        nextCartItems[existingIndex] =
            existing.copyWith(quantity: existing.quantity + 1);
      } else {
        nextCartItems.add(CartItem(item: menuItem, quantity: 1));
      }

      emit(
        state.copyWith(
          cartQuantities: Map.unmodifiable(nextQuantities),
          cartItems: List.unmodifiable(nextCartItems),
        ),
      );
    });

    on<StoreItemRemoved>((event, emit) {
      final nextQuantities = Map<String, int>.of(state.cartQuantities);
      final currentQuantity = nextQuantities[event.itemId] ?? 0;

      if (currentQuantity <= 1) {
        nextQuantities.remove(event.itemId);
      } else {
        nextQuantities[event.itemId] = currentQuantity - 1;
      }

      final nextCartItems = List<CartItem>.from(state.cartItems);
      final existingIndex = nextCartItems.lastIndexWhere(
        (ci) => ci.item.id == event.itemId,
      );

      if (existingIndex >= 0) {
        final existing = nextCartItems[existingIndex];
        if (existing.quantity <= 1) {
          nextCartItems.removeAt(existingIndex);
        } else {
          nextCartItems[existingIndex] =
              existing.copyWith(quantity: existing.quantity - 1);
        }
      }

      emit(
        state.copyWith(
          cartQuantities: Map.unmodifiable(nextQuantities),
          cartItems: List.unmodifiable(nextCartItems),
        ),
      );
    });

    on<StoreCustomItemAdded>((event, emit) {
      final nextQuantities = Map<String, int>.of(state.cartQuantities);
      nextQuantities.update(
        event.item.id,
        (q) => q + event.quantity,
        ifAbsent: () => event.quantity,
      );

      final nextCartItems = List<CartItem>.from(state.cartItems);
      nextCartItems.add(
        CartItem(
          item: event.item,
          quantity: event.quantity,
          selectedOptions: event.selectedOptions,
          specialInstructions: event.specialInstructions,
        ),
      );

      emit(
        state.copyWith(
          cartQuantities: Map.unmodifiable(nextQuantities),
          cartItems: List.unmodifiable(nextCartItems),
        ),
      );
    });

    on<StoreCartCleared>((event, emit) {
      emit(
        state.copyWith(
          cartQuantities: const {},
          cartItems: const [],
        ),
      );
    });
  }
}
