import 'package:flutter/material.dart';

import '../../data/store_models.dart';

class PromotionsCarousel extends StatelessWidget {
  const PromotionsCarousel({
    super.key,
    required this.offers,
  });

  final List<StoreOffer> offers;

  @override
  Widget build(BuildContext context) {
    if (offers.isEmpty) return const SizedBox.shrink();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        height: 100,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: offers.length,
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            final offer = offers[index];
            return _TicketVoucherCard(offer: offer);
          },
        ),
      ),
    );
  }
}

class _TicketVoucherCard extends StatelessWidget {
  const _TicketVoucherCard({required this.offer});

  final StoreOffer offer;

  static const Color _ink = Color(0xFF1E2229);
  static const Color _muted = Color(0xFF757A82);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 215,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          // Upper section: Icon + Title
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 6),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: offer.iconBgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      offer.iconData,
                      size: 18,
                      color: offer.iconColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          offer.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _ink,
                            height: 1.2,
                          ),
                        ),
                        if (offer.subtitle.isNotEmpty && !offer.isApplied) ...[
                          const SizedBox(height: 2),
                          Text(
                            offer.subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 9,
                              color: _muted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Divider with ticket cutouts style
          Container(
            height: 1,
            color: const Color(0xFFE5E7EB),
          ),
          // Bottom action strip
          Container(
            height: 28,
            decoration: BoxDecoration(
              color: offer.isApplied
                  ? const Color(0xFFEBF7ED)
                  : const Color(0xFFFAFAFA),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(11),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (offer.isApplied) ...[
                  const Text(
                    'Applied',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.check_circle_rounded,
                    size: 14,
                    color: Color(0xFF2E7D32),
                  ),
                ] else
                  const Text(
                    'More info',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _ink,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
