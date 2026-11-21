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

  static const Color _ink = Color(0xFF1E2229);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      buildWhen: (prev, curr) => prev.isFavorite != curr.isFavorite,
      builder: (context, state) {
        return SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: _ink,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _HeaderCircleButton(
              icon: Icons.arrow_back_ios_new_rounded,
              size: 16,
              tooltip: 'Back',
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ),
          actions: [
            _HeaderCircleButton(
              icon: state.isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              tooltip: 'Favorite',
              iconColor: state.isFavorite ? const Color(0xFFE84242) : _ink,
              onPressed: () {
                context.read<StoreBloc>().add(const StoreFavoriteToggled());
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
            const SizedBox(width: 8),
            _HeaderCircleButton(
              icon: Icons.ios_share_rounded,
              tooltip: 'Share store',
              onPressed: onShareTap,
            ),
            const SizedBox(width: 8),
            _HeaderCircleButton(
              icon: Icons.search_rounded,
              tooltip: 'Search menu',
              onPressed: onSearchTap,
            ),
            const SizedBox(width: 14),
          ],
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
            title: LayoutBuilder(
              builder: (context, constraints) {
                final isCollapsed = constraints.maxHeight <= 100;
                if (!isCollapsed) return const SizedBox.shrink();
                return Text(
                  store.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _ink,
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
                    color: const Color(0xFFE8DFD8),
                    child: const Icon(
                      Icons.restaurant_rounded,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Gradient scrim at top for contrast
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
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HeaderCircleButton extends StatelessWidget {
  const _HeaderCircleButton({
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
            color: Color(0x18000000),
            blurRadius: 6,
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
