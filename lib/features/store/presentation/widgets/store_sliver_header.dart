import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/store_bloc.dart';
import '../../bloc/store_event.dart';
import '../../bloc/store_state.dart';
import '../../data/store_models.dart';

class StoreSliverHeader extends StatelessWidget {
  const StoreSliverHeader({
    super.key,
    required this.store,
    required this.onSearchTap,
    required this.onShareTap,
  });

  final Store store;
  final VoidCallback onSearchTap;
  final VoidCallback onShareTap;

  static const Color _brandDark = Color(0xFF1E2229);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      buildWhen: (prev, curr) => prev.isFavorite != curr.isFavorite,
      builder: (context, state) {
        return SliverAppBar(
          expandedHeight: 220,
          pinned: true,
          elevation: 1,
          backgroundColor: Colors.white,
          foregroundColor: _brandDark,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _CircleActionButton(
              icon: Icons.arrow_back_rounded,
              tooltip: 'Back',
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ),
          actions: [
            _CircleActionButton(
              icon: Icons.search_rounded,
              tooltip: 'Search menu',
              onPressed: onSearchTap,
            ),
            const SizedBox(width: 6),
            _CircleActionButton(
              icon: Icons.share_outlined,
              tooltip: 'Share store',
              onPressed: onShareTap,
            ),
            const SizedBox(width: 6),
            _CircleActionButton(
              icon: state.isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              tooltip: 'Favorite',
              iconColor: state.isFavorite ? const Color(0xFFE84242) : _brandDark,
              onPressed: () {
                context.read<StoreBloc>().add(const StoreFavoriteToggled());
                final isNowFav = !state.isFavorite;
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                        isNowFav
                            ? 'Added to your favorites'
                            : 'Removed from favorites',
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
              },
            ),
            const SizedBox(width: 14),
          ],
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            titlePadding: const EdgeInsets.only(left: 60, bottom: 16),
            title: LayoutBuilder(
              builder: (context, constraints) {
                // Show title only when collapsed
                final isCollapsed = constraints.maxHeight <= 100;
                if (!isCollapsed) return const SizedBox.shrink();

                return Text(
                  store.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _brandDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                );
              },
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  store.heroImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFF2C3E50),
                    child: const Center(
                      child: Icon(
                        Icons.restaurant_rounded,
                        size: 48,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ),
                // Gradient scrim for top buttons
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                      colors: [
                        Color(0x88000000),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                // Bottom badge: "Talabat Recommended"
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.local_fire_department_rounded,
                          size: 14,
                          color: Color(0xFFE84242),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'TOP RATED IN DUBAI',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: _brandDark,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  const _CircleActionButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.iconColor,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: Colors.white,
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        iconSize: 20,
        icon: Icon(icon, color: iconColor ?? const Color(0xFF1E2229)),
        tooltip: tooltip,
        onPressed: onPressed,
      ),
    );
  }
}
