import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/store_bloc.dart';
import '../bloc/store_event.dart';
import '../bloc/store_state.dart';
import 'widgets/basket_bottom_bar.dart';
import 'widgets/category_sticky_tab_bar.dart';
import 'widgets/delivery_mode_switch.dart';
import 'widgets/menu_item_tile.dart';
import 'widgets/promotions_carousel.dart';
import 'widgets/store_info_card.dart';
import 'widgets/store_sliver_header.dart';

class StoreDetailScreen extends StatefulWidget {
  const StoreDetailScreen({super.key});

  @override
  State<StoreDetailScreen> createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  static const Color _ink = Color(0xFF1E2229);
  static const Color _muted = Color(0xFF757A82);
  static const Color _line = Color(0xFFEBECEF);
  static const Color _accent = Color(0xFFE84242);

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _scrollToSearch() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        340.0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
    _searchFocusNode.requestFocus();
  }

  void _handleShare() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text("Luca's Kitchen link copied to clipboard!"),
          duration: Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        final visibleItems = state.visibleItems;

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          body: SafeArea(
            top: false,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // 1. Collapsing Hero Header
                StoreSliverHeader(
                  store: state.store,
                  onSearchTap: _scrollToSearch,
                  onShareTap: _handleShare,
                ),

                // 2. Store Info Card
                SliverToBoxAdapter(child: StoreInfoCard(store: state.store)),

                // 3. Delivery / Pick-up Switcher
                SliverToBoxAdapter(
                  child: DeliveryModeSwitch(store: state.store),
                ),

                // 4. Promo Deals Carousel
                SliverToBoxAdapter(
                  child: PromotionsCarousel(offers: state.store.offers),
                ),

                // 5. Sticky Search & Category Navigation Bar
                SliverPersistentHeader(
                  pinned: true,
                  delegate: CategoryStickyTabBar(
                    categories: state.store.categories,
                    searchController: _searchController,
                    searchFocusNode: _searchFocusNode,
                  ),
                ),

                // 6. Category Section Header
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.selectedCategory,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: _ink,
                          ),
                        ),
                        Text(
                          '${visibleItems.length} items',
                          style: const TextStyle(
                            fontSize: 12,
                            color: _muted,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 7. Menu Items List or Empty State
                if (visibleItems.isEmpty)
                  SliverToBoxAdapter(
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 48,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.search_off_rounded,
                            size: 48,
                            color: _muted,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'No items match your search',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: _ink,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Try searching with a different keyword or explore another category.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, color: _muted),
                          ),
                          const SizedBox(height: 16),
                          OutlinedButton(
                            onPressed: () {
                              _searchController.clear();
                              context.read<StoreBloc>().add(
                                const StoreSearchChanged(''),
                              );
                              context.read<StoreBloc>().add(
                                const StoreCategorySelected('Popular'),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: _accent),
                              foregroundColor: _accent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Reset Filters'),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverToBoxAdapter(
                    child: Container(
                      color: Colors.white,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: visibleItems.length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1, indent: 16, color: _line),
                        itemBuilder: (context, index) {
                          final item = visibleItems[index];
                          return MenuItemTile(
                            item: item,
                            quantity: state.getItemQuantity(item.id),
                          );
                        },
                      ),
                    ),
                  ),

                // Spacing at bottom
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            ),
          ),
          bottomNavigationBar: state.cartItemCount == 0
              ? const _StoreBottomNav()
              : BasketBottomBar(state: state),
        );
      },
    );
  }
}

class _StoreBottomNav extends StatelessWidget {
  const _StoreBottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEBECEF))),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_filled,
                label: 'Home',
                isActive: false,
                onTap: () {},
              ),
              _NavItem(
                icon: Icons.search_rounded,
                label: 'Browse',
                isActive: true,
                onTap: () {},
              ),
              _NavItem(
                icon: Icons.receipt_long_rounded,
                label: 'Orders',
                isActive: false,
                onTap: () {},
              ),
              _NavItem(
                icon: Icons.person_outline_rounded,
                label: 'Account',
                isActive: false,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? const Color(0xFFE84242) : const Color(0xFF757A82);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
