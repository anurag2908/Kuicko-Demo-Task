import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/store_bloc.dart';
import '../../bloc/store_event.dart';
import '../../bloc/store_state.dart';
import '../../data/store_models.dart';

class DeliveryModeSwitch extends StatelessWidget {
  const DeliveryModeSwitch({
    super.key,
    required this.store,
  });

  final Store store;

  static const Color _ink = Color(0xFF1E2229);
  static const Color _muted = Color(0xFF757A82);
  static const Color _accent = Color(0xFFE84242);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      buildWhen: (prev, curr) => prev.isDelivery != curr.isDelivery,
      builder: (context, state) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Container(
            height: 44,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F3F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _ModeTab(
                    title: 'Delivery',
                    subtitle: store.deliveryMinutes,
                    icon: Icons.delivery_dining_rounded,
                    isSelected: state.isDelivery,
                    onTap: () {
                      context
                          .read<StoreBloc>()
                          .add(const StoreDeliveryModeToggled(isDelivery: true));
                    },
                  ),
                ),
                Expanded(
                  child: _ModeTab(
                    title: 'Pick-up',
                    subtitle: store.pickupMinutes,
                    icon: Icons.storefront_rounded,
                    isSelected: !state.isDelivery,
                    onTap: () {
                      context.read<StoreBloc>().add(
                            const StoreDeliveryModeToggled(isDelivery: false),
                          );
                    },
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

class _ModeTab extends StatelessWidget {
  const _ModeTab({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected
                  ? const Color(0xFFE84242)
                  : const Color(0xFF757A82),
            ),
            const SizedBox(width: 6),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                    color: isSelected
                        ? const Color(0xFF1E2229)
                        : const Color(0xFF757A82),
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 9,
                    color: isSelected
                        ? const Color(0xFF757A82)
                        : const Color(0xFF9EA3A9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
