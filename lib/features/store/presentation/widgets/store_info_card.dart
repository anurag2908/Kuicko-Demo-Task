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
  static const Color _talabatOrange = Color(0xFFFF5A00);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Transform.translate(
        offset: const Offset(0, -28),
        child: InkWell(
          onTap: () => showStoreInfoSheet(context, store),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Logo + Info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // OVENTINE Logo
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F4C5C),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'OVENTINE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.5,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Title & details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  store.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: _ink,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right_rounded,
                                size: 20,
                                color: _muted,
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          // Trending Tagline
                          const Row(
                            children: [
                              Icon(
                                Icons.trending_up_rounded,
                                size: 14,
                                color: Color(0xFF2C7BE5),
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Top rated in Arabic',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF2C7BE5),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          // Rating & Badge
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                size: 16,
                                color: Color(0xFFF5A623),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                '${store.rating}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: _ink,
                                ),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                '(${(store.reviewCount / 1000).toStringAsFixed(0)}k+)',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: _muted,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF2E8),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.emoji_events_rounded,
                                      size: 11,
                                      color: _talabatOrange,
                                    ),
                                    SizedBox(width: 3),
                                    Text(
                                      'Exceptional',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                        color: _talabatOrange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Delivery metrics row
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: _ink,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        store.deliveryMinutes,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _ink,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text('•', style: TextStyle(color: _muted)),
                      ),
                      const Icon(
                        Icons.delivery_dining_rounded,
                        size: 15,
                        color: _ink,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        store.deliveryFeeText,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _ink,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text('•', style: TextStyle(color: _muted)),
                      ),
                      const Text(
                        'Delivered by ',
                        style: TextStyle(fontSize: 11, color: _muted),
                      ),
                      const Text(
                        'talabat',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: _talabatOrange,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.info_outline_rounded,
                        size: 12,
                        color: _muted,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Bottom promo banner: Get your first 4 orders delivered free
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3EB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.delivery_dining_rounded,
                        size: 16,
                        color: _talabatOrange,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          store.freeDeliveryPromo,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _talabatOrange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
