import 'package:flutter/material.dart';

import '../../data/store_models.dart';
import 'store_info_sheet.dart';

class StoreInfoCard extends StatelessWidget {
  const StoreInfoCard({
    super.key,
    required this.store,
  });

  final Store store;

  static const Color _ink = Color(0xFF1E2229);
  static const Color _muted = Color(0xFF757A82);
  static const Color _line = Color(0xFFEBECEF);
  static const Color _accent = Color(0xFFE84242);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Store Logo Box
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 58,
                  height: 58,
                  color: Colors.grey.shade100,
                  child: Image.network(
                    store.logoImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.fastfood_rounded,
                      color: _accent,
                      size: 28,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // Store Title & Cuisine
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store.name,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      store.cuisine,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: _muted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Store Info trigger icon
              InkWell(
                onTap: () => showStoreInfoSheet(context, store),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.info_outline_rounded,
                    size: 20,
                    color: _ink,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Delivery & Rating stats bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _line),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _StatItem(
                    icon: Icons.star_rounded,
                    iconColor: const Color(0xFFF5A623),
                    title: '${store.rating}',
                    subtitle: '(${(store.reviewCount / 1000).toStringAsFixed(1)}k+)',
                    isBold: true,
                  ),
                ),
                _VerticalDivider(),
                Expanded(
                  child: _StatItem(
                    icon: Icons.access_time_rounded,
                    iconColor: const Color(0xFF2C7BE5),
                    title: store.deliveryMinutes,
                    subtitle: 'Delivery',
                  ),
                ),
                _VerticalDivider(),
                Expanded(
                  child: _StatItem(
                    icon: Icons.delivery_dining_rounded,
                    iconColor: const Color(0xFF2ECC71),
                    title: 'AED ${store.deliveryFee.toStringAsFixed(0)}',
                    subtitle: 'Fee',
                  ),
                ),
                _VerticalDivider(),
                Expanded(
                  child: _StatItem(
                    icon: Icons.shopping_bag_outlined,
                    iconColor: _muted,
                    title: 'AED ${store.minimumOrder.toStringAsFixed(0)}',
                    subtitle: 'Min order',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Deliver to Dubai location pill
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 16,
                color: _accent,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Delivering to ${store.address}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: _ink,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 18,
                color: _muted,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.isBold = false,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: iconColor),
            const SizedBox(width: 2),
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isBold ? FontWeight.w800 : FontWeight.w700,
                  color: const Color(0xFF1E2229),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 9,
            color: Color(0xFF757A82),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 22,
      color: const Color(0xFFEBECEF),
    );
  }
}
