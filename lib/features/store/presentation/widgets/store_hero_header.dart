import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/store_bloc.dart';
import '../../bloc/store_event.dart';
import '../../bloc/store_state.dart';
import '../../data/store_models.dart';
import 'store_info_card.dart';

class StoreHeroHeader extends StatelessWidget {
  const StoreHeroHeader({
    super.key,
    required this.store,
    required this.onSearchTap,
    required this.onShareTap,
  });

  final Store store;
  final VoidCallback onSearchTap;
  final VoidCallback onShareTap;

  static const Color _ink = Color(0xFF1E2229);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      buildWhen: (prev, curr) => prev.isFavorite != curr.isFavorite,
      builder: (context, state) {
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            // Background Column: Hero Image + White area for overlap
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. Hero Image with Actions
                SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        store.heroImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: const Color(0xFF2C3E50),
                          child: const Icon(
                            Icons.restaurant_rounded,
                            size: 48,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // Top gradient for button contrast
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.center,
                            colors: [
                              Color(0x66000000),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      // Top Action Bar
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 8,
                        left: 16,
                        right: 16,
                        child: Row(
                          children: [
                            _CircleActionBtn(
                              icon: Icons.arrow_back_ios_new_rounded,
                              size: 16,
                              tooltip: 'Back',
                              onPressed: () =>
                                  Navigator.of(context).maybePop(),
                            ),
                            const Spacer(),
                            _CircleActionBtn(
                              icon: state.isFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              tooltip: 'Favorite',
                              iconColor: state.isFavorite
                                  ? const Color(0xFFE84242)
                                  : _ink,
                              onPressed: () {
                                context
                                    .read<StoreBloc>()
                                    .add(const StoreFavoriteToggled());
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        !state.isFavorite
                                            ? 'Added to your favorites'
                                            : 'Removed from favorites',
                                      ),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                              },
                            ),
                            const SizedBox(width: 10),
                            _CircleActionBtn(
                              icon: Icons.ios_share_rounded,
                              tooltip: 'Share store',
                              onPressed: onShareTap,
                            ),
                            const SizedBox(width: 10),
                            _CircleActionBtn(
                              icon: Icons.search_rounded,
                              tooltip: 'Search menu',
                              onPressed: onSearchTap,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // 2. Space beneath image for card overlap
                Container(
                  height: 90,
                  color: Colors.white,
                ),
              ],
            ),
            // Floating Overlapping Card
            Positioned(
              left: 16,
              right: 16,
              bottom: 4,
              child: StoreInfoCard(store: store),
            ),
          ],
        );
      },
    );
  }
}

class _CircleActionBtn extends StatelessWidget {
  const _CircleActionBtn({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.iconColor,
    this.size = 18,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final Color? iconColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        iconSize: size,
        icon: Icon(icon, color: iconColor ?? const Color(0xFF1E2229)),
        tooltip: tooltip,
        onPressed: onPressed,
      ),
    );
  }
}
