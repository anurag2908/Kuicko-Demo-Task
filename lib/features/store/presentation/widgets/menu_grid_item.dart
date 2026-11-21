import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/store_bloc.dart';
import '../../bloc/store_event.dart';
import '../../data/store_models.dart';
import 'item_customization_sheet.dart';

class MenuGridItem extends StatelessWidget {
  const MenuGridItem({
    super.key,
    required this.item,
    required this.quantity,
  });

  final MenuItem item;
  final int quantity;

  static const Color _ink = Color(0xFF1E2229);
  static const Color _talabatOrange = Color(0xFFFF5A00);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleTap(context),
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food Image with Floating Circle Button
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  height: 110,
                  width: double.infinity,
                  color: item.imageBgColor,
                  child: Image.network(
                    item.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(
                        Icons.fastfood_rounded,
                        size: 36,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ),
              ),
              // Floating round action button at bottom-right of image
              Positioned(
                right: 8,
                bottom: -10,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x22000000),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 18,
                    icon: Icon(
                      quantity > 0 ? Icons.check_rounded : Icons.chevron_right_rounded,
                      color: quantity > 0 ? const Color(0xFF2E7D32) : _talabatOrange,
                    ),
                    onPressed: () => _handleTap(context),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Name
          Text(
            item.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: _ink,
            ),
          ),
          const SizedBox(height: 3),
          // Price with Dirham symbol د.إ
          Text(
            'د.إ ${item.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _ink,
            ),
          ),
        ],
      ),
    );
  }

  void _handleTap(BuildContext context) {
    if (item.optionGroups.isNotEmpty || item.isCustomizable) {
      showItemCustomizationSheet(context, item);
    } else {
      context.read<StoreBloc>().add(StoreItemAdded(item.id));
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Added ${item.name} to basket'),
            duration: const Duration(seconds: 1),
          ),
        );
    }
  }
}
