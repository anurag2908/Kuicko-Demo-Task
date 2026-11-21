import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/store_bloc.dart';
import '../bloc/store_event.dart';
import '../bloc/store_state.dart';
import 'widgets/basket_bottom_bar.dart';
import 'widgets/category_sticky_tab_bar.dart';
import 'widgets/menu_grid_item.dart';
import 'widgets/menu_row_item.dart';
import 'widgets/promotions_carousel.dart';
import 'widgets/store_hero_header.dart';

class StoreDetailScreen extends StatefulWidget {
  const StoreDetailScreen({super.key});

  @override
  State<StoreDetailScreen> createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  static const Color _ink = Color(0xFF1E2229);
  static const Color _muted = Color(0xFF757A82);

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showCategoryPicker(BuildContext context, List<String> categories) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Menu Categories',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: _ink,
                ),
              ),
              const SizedBox(height: 10),
              ...categories.map(
                (cat) => ListTile(
                  title: Text(
                    cat,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                    ),
                  ),
                  onTap: () {
                    context.read<StoreBloc>().add(StoreCategorySelected(cat));
                    Navigator.pop(sheetContext);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search dishes...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear_rounded),
                  onPressed: () {
                    _searchController.clear();
                    context.read<StoreBloc>().add(const StoreSearchChanged(''));
                  },
                ),
                filled: true,
                fillColor: const Color(0xFFF1F3F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) {
                context.read<StoreBloc>().add(StoreSearchChanged(val));
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _handleShare() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Store link copied to clipboard!'),
          duration: Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        final picksForYouItems = state.store.menuItems
            .where(
              (item) =>
                  item.category == 'Picks for you 🔥' &&
                  (state.searchQuery.isEmpty ||
                      item.name.toLowerCase().contains(
                        state.searchQuery.toLowerCase(),
                      )),
            )
            .toList();

        final macroItems = state.store.menuItems
            .where(
              (item) =>
                  item.category == 'Macro Madness' &&
                  (state.searchQuery.isEmpty ||
                      item.name.toLowerCase().contains(
                        state.searchQuery.toLowerCase(),
                      )),
            )
            .toList();

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark, // White icons & text on iOS (time, battery, wifi)
            statusBarIconBrightness: Brightness.light, // White icons on Android
          ),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              top: false,
              child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // 1. Hero Image with Floating Store Card (No clipping!)
                SliverToBoxAdapter(
                  child: StoreHeroHeader(
                    store: state.store,
                    onSearchTap: () => _showSearchDialog(context),
                    onShareTap: _handleShare,
                  ),
                ),

                // 2. Ticket Vouchers Carousel
                SliverToBoxAdapter(
                  child: PromotionsCarousel(offers: state.store.offers),
                ),

                // 3. Sticky Category Tab Bar with Menu Icon
                SliverPersistentHeader(
                  pinned: true,
                  delegate: CategoryStickyTabBar(
                    categories: state.store.categories,
                    onMenuTap: () =>
                        _showCategoryPicker(context, state.store.categories),
                  ),
                ),

                // 4. Section 1: "Picks for you 🔥"
                if (picksForYouItems.isNotEmpty &&
                    (state.selectedCategory == 'Picks for you 🔥' ||
                        state.searchQuery.isNotEmpty)) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Picks for you 🔥',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: _ink,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Trending items we think you'll love",
                            style: TextStyle(fontSize: 12, color: _muted),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 22),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 18,
                            childAspectRatio: 0.88,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final item = picksForYouItems[index];
                        return MenuGridItem(
                          item: item,
                          quantity: state.getItemQuantity(item.id),
                        );
                      }, childCount: picksForYouItems.length),
                    ),
                  ),
                ],

                // 5. Section 2: "Macro Madness"
                if (macroItems.isNotEmpty &&
                    (state.selectedCategory == 'Macro Madness' ||
                        state.selectedCategory == 'Picks for you 🔥' ||
                        state.searchQuery.isNotEmpty)) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                      child: const Text(
                        'Macro Madness',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: _ink,
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = macroItems[index];
                      return MenuRowItem(
                        item: item,
                        quantity: state.getItemQuantity(item.id),
                      );
                    }, childCount: macroItems.length),
                  ),
                ],

                // 6. Generous Bottom Padding
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            ),
          ),
          bottomNavigationBar: BasketBottomBar(state: state),
        ),
      );
      },
    );
  }
}
