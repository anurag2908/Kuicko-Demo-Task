import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/store_bloc.dart';
import '../../bloc/store_event.dart';
import '../../data/store_models.dart';
import 'item_customization_sheet.dart';

class MenuItemTile extends StatelessWidget {
  const MenuItemTile({
    super.key,
    required this.item,
    required this.quantity,
  });

  final MenuItem item;
  final int quantity;

  static const Color _ink = Color(0xFF1E2229);
  static const Color _muted = Color(0xFF757A82);
  static const Color _accent = Color(0xFFE84242);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleItemTap(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Details column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badges: Veg, Spicy, Bestseller
                  Row(
                    children: [
                      if (item.isVegetarian) ...[
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF2ECC71),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(
                            Icons.circle,
                            size: 8,
                            color: Color(0xFF2ECC71),
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                      if (item.isSpicy) ...[
                        const Icon(
                          Icons.whatshot_rounded,
                          size: 14,
                          color: Color(0xFFE84242),
                        ),
                        const SizedBox(width: 4),
                      ],
                      if (item.isPopular)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF0F0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.local_fire_department_rounded,
                                size: 12,
                                color: _accent,
                              ),
                              SizedBox(width: 2),
                              Text(
                                'Bestseller',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: _accent,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  if (item.isVegetarian || item.isSpicy || item.isPopular)
                    const SizedBox(height: 5),
                  // Title
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Description
                  Text(
                    item.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: _muted,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Price row with Wrap
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      Text(
                        'AED ${item.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: _ink,
                        ),
                      ),
                      if (item.hasDiscount)
                        Text(
                          'AED ${item.originalPrice!.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: _muted,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      if (item.isCustomizable)
                        const Text(
                          'Customizable',
                          style: TextStyle(
                            fontSize: 11,
                            color: _muted,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            // Food image & Add button
            SizedBox(
              width: 108,
              height: 104,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 108,
                      height: 94,
                      color: const Color(0xFFF1F3F5),
                      child: Image.network(
                        item.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                          child: Icon(
                            Icons.fastfood_rounded,
                            size: 32,
                            color: Color(0xFFCED4DA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Add / Quantity button
                  Positioned(
                    bottom: 0,
                    left: 12,
                    right: 12,
                    child: quantity == 0
                        ? _AddButton(
                            onPressed: () {
                              context
                                  .read<StoreBloc>()
                                  .add(StoreItemAdded(item.id));
                            },
                          )
                        : _QuantityStepper(
                            quantity: quantity,
                            onAdd: () {
                              context
                                  .read<StoreBloc>()
                                  .add(StoreItemAdded(item.id));
                            },
                            onRemove: () {
                              context
                                  .read<StoreBloc>()
                                  .add(StoreItemRemoved(item.id));
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleItemTap(BuildContext context) {
    if (item.isCustomizable) {
      showItemCustomizationSheet(context, item);
    } else {
      context.read<StoreBloc>().add(StoreItemAdded(item.id));
    }
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFFE84242),
          side: const BorderSide(color: Color(0xFFE84242), width: 1.2),
          padding: EdgeInsets.zero,
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'ADD',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: const Color(0xFFE84242),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE84242).withOpacity(0.35),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: onRemove,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Icon(Icons.remove, size: 16, color: Colors.white),
            ),
          ),
          Text(
            '$quantity',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          InkWell(
            onTap: onAdd,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Icon(Icons.add, size: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
