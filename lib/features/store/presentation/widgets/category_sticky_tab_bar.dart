import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/store_bloc.dart';
import '../../bloc/store_event.dart';
import '../../bloc/store_state.dart';

class CategoryStickyTabBar extends SliverPersistentHeaderDelegate {
  CategoryStickyTabBar({
    required this.categories,
    required this.searchController,
    required this.searchFocusNode,
  });

  final List<String> categories;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;

  static const double _headerHeight = 106.0;

  @override
  double get minExtent => _headerHeight;

  @override
  double get maxExtent => _headerHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return BlocBuilder<StoreBloc, StoreState>(
      buildWhen: (prev, curr) =>
          prev.selectedCategory != curr.selectedCategory ||
          prev.searchQuery != curr.searchQuery,
      builder: (context, state) {
        return Container(
          height: _headerHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: overlapsContent
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
            border: const Border(
              bottom: BorderSide(color: Color(0xFFEBECEF), width: 1),
            ),
          ),
          child: Column(
            children: [
              // Search input
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
                child: SizedBox(
                  height: 38,
                  child: TextField(
                    controller: searchController,
                    focusNode: searchFocusNode,
                    onChanged: (val) {
                      context
                          .read<StoreBloc>()
                          .add(StoreSearchChanged(val));
                    },
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF1E2229),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search dishes or categories...',
                      hintStyle: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF757A82),
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        size: 18,
                        color: Color(0xFF757A82),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded, size: 16),
                              color: const Color(0xFF757A82),
                              onPressed: () {
                                searchController.clear();
                                context
                                    .read<StoreBloc>()
                                    .add(const StoreSearchChanged(''));
                              },
                            )
                          : null,
                      suffixIconConstraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF1F3F5),
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              // Category pills
              SizedBox(
                height: 44,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    final isSelected = state.selectedCategory.toLowerCase() ==
                        cat.toLowerCase();

                    return Center(
                      child: ChoiceChip(
                        label: Text(cat),
                        selected: isSelected,
                        onSelected: (_) {
                          context
                              .read<StoreBloc>()
                              .add(StoreCategorySelected(cat));
                        },
                        showCheckmark: false,
                        labelStyle: TextStyle(
                          fontSize: 12,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF1E2229),
                        ),
                        backgroundColor: const Color(0xFFF1F3F5),
                        selectedColor: const Color(0xFFE84242),
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
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
