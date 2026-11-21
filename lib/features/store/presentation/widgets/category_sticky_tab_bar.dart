import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/store_bloc.dart';
import '../../bloc/store_event.dart';
import '../../bloc/store_state.dart';

class CategoryStickyTabBar extends SliverPersistentHeaderDelegate {
  CategoryStickyTabBar({
    required this.categories,
    required this.onMenuTap,
  });

  final List<String> categories;
  final VoidCallback onMenuTap;

  static const double _height = 48.0;

  @override
  double get minExtent => _height;

  @override
  double get maxExtent => _height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return BlocBuilder<StoreBloc, StoreState>(
      buildWhen: (prev, curr) =>
          prev.selectedCategory != curr.selectedCategory,
      builder: (context, state) {
        return Container(
          height: _height,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: overlapsContent
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
            border: const Border(
              bottom: BorderSide(color: Color(0xFFEBECEF), width: 1),
            ),
          ),
          child: Row(
            children: [
              // Menu icon button ☰
              IconButton(
                onPressed: onMenuTap,
                icon: const Icon(
                  Icons.menu_rounded,
                  size: 22,
                  color: Color(0xFF1E2229),
                ),
                tooltip: 'All categories',
                padding: const EdgeInsets.only(left: 14, right: 8),
                constraints: const BoxConstraints(),
              ),
              // Category Tabs
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 18),
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    final isSelected = state.selectedCategory == cat;

                    return InkWell(
                      onTap: () {
                        context
                            .read<StoreBloc>()
                            .add(StoreCategorySelected(cat));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              cat,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isSelected
                                    ? FontWeight.w800
                                    : FontWeight.w500,
                                color: isSelected
                                    ? const Color(0xFF1E2229)
                                    : const Color(0xFF757A82),
                              ),
                            ),
                          ),
                          // Underline indicator
                          Container(
                            height: 2.5,
                            width: 24,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF1E2229)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool shouldRebuild(covariant CategoryStickyTabBar oldDelegate) {
    return categories != oldDelegate.categories;
  }
}
