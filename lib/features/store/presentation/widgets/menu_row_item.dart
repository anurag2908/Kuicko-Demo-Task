import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/store_bloc.dart';
import '../../bloc/store_event.dart';
import '../../data/store_models.dart';
import 'item_customization_sheet.dart';

class MenuRowItem extends StatelessWidget {
  const MenuRowItem({
    super.key,
    required this.item,
    required this.quantity,
  });

  final MenuItem item;
  final int quantity;

  static const Color _ink = Color(0xFF1E2229);
  static const Color _muted = Color(0xFF757A82);
  static const Color _talabatOrange = Color(0xFFFF5A00);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleTap(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                    ),
                  ),
                  if (item.macros != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      item.macros!,
                      style: const TextStyle(
                        fontSize: 11,
                        color: _muted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  if (item.description.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: _muted,
                        height: 1.35,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    'د.إ ${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            // Right: Image + Action + Customizable label
            Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 110,
                        height: 90,
                        color: item.imageBgColor,
                        child: Image.network(
                          item.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                            child: Icon(
                              Icons.fastfood_rounded,
                              size: 32,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 6,
                      bottom: -8,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x22000000),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 18,
                          icon: const Icon(
                            Icons.chevron_right_rounded,
                            color: _talabatOrange,
                          ),
                          onPressed: () => _handleTap(context),
                        ),
                      ),
                    ),
                  ],
                ),
                if (item.isCustomizable) ...[
                  const SizedBox(height: 10),
                  const Text(
                    'Customizable',
                    style: TextStyle(
                      fontSize: 10,
                      color: _muted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap(BuildContext context) {
    if (item.isCustomizable || item.optionGroups.isNotEmpty) {
      showItemCustomizationSheet(context, item);
    } else {
      context.read<StoreBloc>().add(StoreItemAdded(item.id));
    }
  }
}
