import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/store_bloc.dart';
import '../../bloc/store_event.dart';
import '../../data/store_models.dart';

void showItemCustomizationSheet(BuildContext context, MenuItem item) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) => _CustomizationSheetContent(
      item: item,
      onAddToCart: (selectedOptions, quantity, notes) {
        context.read<StoreBloc>().add(
              StoreCustomItemAdded(
                item: item,
                quantity: quantity,
                selectedOptions: selectedOptions,
                specialInstructions: notes,
              ),
            );
        Navigator.pop(sheetContext);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Added ${item.name} to basket!'),
              duration: const Duration(seconds: 1),
            ),
          );
      },
    ),
  );
}

class _CustomizationSheetContent extends StatefulWidget {
  const _CustomizationSheetContent({
    required this.item,
    required this.onAddToCart,
  });

  final MenuItem item;
  final void Function(
    List<MenuItemOption> selectedOptions,
    int quantity,
    String? notes,
  ) onAddToCart;

  @override
  State<_CustomizationSheetContent> createState() =>
      _CustomizationSheetContentState();
}

class _CustomizationSheetContentState
    extends State<_CustomizationSheetContent> {
  int _quantity = 1;
  final Map<String, List<MenuItemOption>> _selectedOptionsByGroup = {};
  final TextEditingController _notesController = TextEditingController();

  static const Color _ink = Color(0xFF1E2229);
  static const Color _muted = Color(0xFF757A82);
  static const Color _accent = Color(0xFFE84242);

  @override
  void initState() {
    super.initState();
    // Pre-select defaults
    for (final group in widget.item.optionGroups) {
      final defaults = group.options.where((o) => o.isDefault).toList();
      if (defaults.isNotEmpty) {
        _selectedOptionsByGroup[group.title] = defaults;
      } else if (group.isRequired && group.options.isNotEmpty) {
        _selectedOptionsByGroup[group.title] = [group.options.first];
      } else {
        _selectedOptionsByGroup[group.title] = [];
      }
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  double get _currentUnitPrice {
    double total = widget.item.price;
    for (final list in _selectedOptionsByGroup.values) {
      for (final opt in list) {
        total += opt.price;
      }
    }
    return total;
  }

  double get _currentTotalPrice => _currentUnitPrice * _quantity;

  List<MenuItemOption> get _allSelectedOptions {
    final list = <MenuItemOption>[];
    for (final opts in _selectedOptionsByGroup.values) {
      list.addAll(opts);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
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
            // Header Image with close button
            Stack(
              children: [
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: Image.network(
                    widget.item.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade200,
                      child: const Icon(
                        Icons.fastfood_rounded,
                        size: 48,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 12,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 18,
                      icon: const Icon(Icons.close_rounded, color: _ink),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
            // Scrollable Content
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                children: [
                  Text(
                    widget.item.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.item.description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: _muted,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'AED ${widget.item.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: _accent,
                        ),
                      ),
                      if (widget.item.calories != null) ...[
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${widget.item.calories} kcal',
                            style: const TextStyle(
                              fontSize: 11,
                              color: _muted,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const Divider(height: 24),
                  // Options Groups
                  ...widget.item.optionGroups.map((group) {
                    final selectedList =
                        _selectedOptionsByGroup[group.title] ?? [];
                    final isSingleChoice = group.maxSelections == 1;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                group.title,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: _ink,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: group.isRequired
                                      ? const Color(0xFFFFF0F0)
                                      : const Color(0xFFF1F3F5),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  group.isRequired ? 'REQUIRED' : 'OPTIONAL',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    color: group.isRequired
                                        ? _accent
                                        : _muted,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ...group.options.map((opt) {
                            final isOptSelected = selectedList.contains(opt);

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  if (isSingleChoice) {
                                    _selectedOptionsByGroup[group.title] = [
                                      opt
                                    ];
                                  } else {
                                    if (isOptSelected) {
                                      selectedList.remove(opt);
                                    } else {
                                      if (selectedList.length <
                                          group.maxSelections) {
                                        selectedList.add(opt);
                                      }
                                    }
                                    _selectedOptionsByGroup[group.title] =
                                        selectedList;
                                  }
                                });
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      isSingleChoice
                                          ? (isOptSelected
                                              ? Icons.radio_button_checked
                                              : Icons.radio_button_off)
                                          : (isOptSelected
                                              ? Icons.check_box
                                              : Icons.check_box_outline_blank),
                                      size: 20,
                                      color: isOptSelected ? _accent : _muted,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        opt.name,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: isOptSelected
                                              ? FontWeight.w700
                                              : FontWeight.w500,
                                          color: _ink,
                                        ),
                                      ),
                                    ),
                                    if (opt.price > 0)
                                      Text(
                                        '+AED ${opt.price.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: _muted,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  }),
                  // Special instructions
                  const Text(
                    'Special Instructions (Optional)',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _notesController,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      hintText:
                          'e.g. Extra napkins, no pickles, sauce on the side...',
                      hintStyle: const TextStyle(fontSize: 12, color: _muted),
                      filled: true,
                      fillColor: const Color(0xFFF8F9FA),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: _accent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            // Bottom Action Bar
            SafeArea(
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Color(0xFFEBECEF)),
                  ),
                ),
                child: Row(
                  children: [
                    // Quantity stepper
                    Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 18),
                            onPressed: _quantity > 1
                                ? () => setState(() => _quantity--)
                                : null,
                            color: _accent,
                          ),
                          Text(
                            '$_quantity',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: _ink,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 18),
                            onPressed: () => setState(() => _quantity++),
                            color: _accent,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Add to cart CTA
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: FilledButton(
                          onPressed: () {
                            widget.onAddToCart(
                              _allSelectedOptions,
                              _quantity,
                              _notesController.text.trim().isEmpty
                                  ? null
                                  : _notesController.text.trim(),
                            );
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: _accent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Add to Basket',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                'AED ${_currentTotalPrice.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
