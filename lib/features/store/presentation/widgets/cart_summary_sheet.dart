import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/store_bloc.dart';
import '../../bloc/store_event.dart';
import '../../bloc/store_state.dart';

void showCartSummarySheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) => BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        return _CartSummaryContent(state: state);
      },
    ),
  );
}

class _CartSummaryContent extends StatelessWidget {
  const _CartSummaryContent({required this.state});

  final StoreState state;

  static const Color _ink = Color(0xFF1E2229);
  static const Color _muted = Color(0xFF757A82);
  static const Color _talabatOrange = Color(0xFFFF5A00);
  static const Color _line = Color(0xFFEBECEF);

  @override
  Widget build(BuildContext context) {
    if (state.cartItemCount == 0) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.shopping_bag_outlined,
                size: 54,
                color: _muted,
              ),
              const SizedBox(height: 12),
              const Text(
                'Your basket is empty',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: _ink,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Add delicious items from the menu to build your order.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: _muted),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: _talabatOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Browse Menu'),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Handle bar
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 6),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Basket',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: _ink,
                          ),
                        ),
                        Text(
                          state.store.name,
                          style: const TextStyle(fontSize: 12, color: _muted),
                        ),
                      ],
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      context.read<StoreBloc>().add(const StoreCartCleared());
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.delete_outline, size: 16),
                    label: const Text('Clear'),
                    style: TextButton.styleFrom(
                      foregroundColor: _muted,
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: _line),
            // Items List
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                children: [
                  ...state.cartItems.map((cartItem) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Quantity box
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F3F5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '${cartItem.quantity}x',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: _ink,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Item details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartItem.item.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: _ink,
                                  ),
                                ),
                                if (cartItem.selectedOptions.isNotEmpty) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    cartItem.selectedOptions
                                        .map((o) => o.name)
                                        .join(', '),
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: _muted,
                                    ),
                                  ),
                                ],
                                if (cartItem.specialInstructions != null &&
                                    cartItem
                                        .specialInstructions!.isNotEmpty) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    'Note: ${cartItem.specialInstructions}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontStyle: FontStyle.italic,
                                      color: _muted,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          // Price
                          Text(
                            'د.إ ${cartItem.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: _ink,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 14),
                  const Divider(color: _line),
                  const SizedBox(height: 8),
                  // Bill Breakdown
                  const Text(
                    'Bill Summary',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _SummaryRow(
                    label: 'Subtotal',
                    value: 'د.إ ${state.subtotal.toStringAsFixed(2)}',
                  ),
                  const SizedBox(height: 6),
                  _SummaryRow(
                    label: 'Delivery Fee',
                    value: 'Free',
                    valueColor: const Color(0xFF2E7D32),
                  ),
                  const SizedBox(height: 6),
                  _SummaryRow(
                    label: 'UAE VAT (5%)',
                    value: 'د.إ ${state.vatAmount.toStringAsFixed(2)}',
                  ),
                  const Divider(height: 20, color: _line),
                  _SummaryRow(
                    label: 'Total Amount',
                    value: 'د.إ ${state.grandTotal.toStringAsFixed(2)}',
                    isBold: true,
                  ),
                  const SizedBox(height: 16),
                  // Delivery address info
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _line),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 18,
                          color: _talabatOrange,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Delivery to: ${state.store.address}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: _ink,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Checkout button
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                              'Order placed with ${state.store.name}!',
                            ),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: _talabatOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Place Order',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'د.إ ${state.grandTotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
  });

  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 15 : 13,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
            color: isBold ? const Color(0xFF1E2229) : const Color(0xFF757A82),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 16 : 13,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w700,
            color: valueColor ??
                (isBold ? const Color(0xFFFF5A00) : const Color(0xFF1E2229)),
          ),
        ),
      ],
    );
  }
}
