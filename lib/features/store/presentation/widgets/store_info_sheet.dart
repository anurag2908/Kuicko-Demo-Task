import 'package:flutter/material.dart';

import '../../data/store_models.dart';

void showStoreInfoSheet(BuildContext context, Store store) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => _StoreInfoSheetContent(store: store),
  );
}

class _StoreInfoSheetContent extends StatelessWidget {
  const _StoreInfoSheetContent({required this.store});

  final Store store;

  static const Color _ink = Color(0xFF1E2229);
  static const Color _muted = Color(0xFF757A82);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        store.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: _ink,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        store.cuisine,
                        style: const TextStyle(fontSize: 13, color: _muted),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded, color: _ink),
                ),
              ],
            ),
            const Divider(height: 28),
            _InfoRow(
              icon: Icons.star_rounded,
              iconColor: const Color(0xFFF5A623),
              title: 'Ratings & Reviews',
              subtitle:
                  '${store.rating} ★ based on ${store.reviewCount}+ verified customer orders',
            ),
            const SizedBox(height: 16),
            _InfoRow(
              icon: Icons.location_on_outlined,
              iconColor: const Color(0xFFE84242),
              title: 'Store Location',
              subtitle: '${store.address} (${store.distanceKm} km away)',
            ),
            const SizedBox(height: 16),
            _InfoRow(
              icon: Icons.access_time_rounded,
              iconColor: const Color(0xFF2C7BE5),
              title: 'Operating Hours',
              subtitle: store.openingHours,
            ),
            const SizedBox(height: 16),
            _InfoRow(
              icon: Icons.verified_user_outlined,
              iconColor: const Color(0xFF2ECC71),
              title: 'Food Safety & Hygiene',
              subtitle: store.hygieneScore,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: _ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E2229),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF757A82),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
