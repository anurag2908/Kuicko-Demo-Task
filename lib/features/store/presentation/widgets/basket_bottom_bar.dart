import 'package:flutter/material.dart';

import '../../bloc/store_state.dart';
import 'cart_summary_sheet.dart';

class BasketBottomBar extends StatelessWidget {
  const BasketBottomBar({
    super.key,
    required this.state,
  });

  final StoreState state;

  static const Color _accent = Color(0xFFE84242);

  @override
  Widget build(BuildContext context) {
    if (state.cartItemCount == 0) return const SizedBox.shrink();

    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(16, 6, 16, 12),
      child: SizedBox(
        height: 52,
        child: FilledButton(
          onPressed: () => showCartSummarySheet(context),
          style: FilledButton.styleFrom(
            backgroundColor: _accent,
            elevation: 4,
            shadowColor: _accent.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            children: [
              // Count pill
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.22),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${state.cartItemCount}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // Label
              const Expanded(
                child: Text(
                  'View basket',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              // Price
              Text(
                'AED ${state.subtotal.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
