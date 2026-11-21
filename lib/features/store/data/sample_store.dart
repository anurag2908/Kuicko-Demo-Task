import 'package:flutter/material.dart';

import 'store_models.dart';

const sampleStore = Store(
  name: 'Oventine - By Al Safadi',
  tagline: 'Top rated in Arabic',
  rating: 4.8,
  reviewCount: 1200,
  ratingBadge: 'Exceptional',
  deliveryMinutes: '20-35 mins',
  deliveryFeeText: 'Free',
  deliveredBy: 'Delivered by talabat',
  freeDeliveryPromo: 'Get your first 4 orders delivered free',
  address: 'Downtown Dubai & Al Rigga, Dubai',
  heroImage:
      'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=1200&q=80',
  categories: [
    'Picks for you 🔥',
    'Macro Madness',
    'Oventine Specials',
    'Manakeesh & Pies',
    'Beverages',
  ],
  offers: [
    StoreOffer(
      id: 'offer-1',
      title: 'Free delivery on your order',
      subtitle: 'Free delivery automatically applied',
      actionText: 'Applied',
      isApplied: true,
      iconData: Icons.delivery_dining_rounded,
      iconColor: Color(0xFFE84242),
      iconBgColor: Color(0xFFFFECE5),
    ),
    StoreOffer(
      id: 'offer-2',
      title: '50% - EIB Emirates Islamic Cards "EMR50"',
      subtitle: 'Min. spend د.إ 10 • Up to د.إ 25',
      actionText: 'More info',
      isApplied: false,
      iconData: Icons.credit_card_rounded,
      iconColor: Color(0xFF6B21A8),
      iconBgColor: Color(0xFFF3E8FF),
    ),
  ],
  menuItems: [
    // --- PICKS FOR YOU (Grid Layout) ---
    MenuItem(
      id: 'akkawi',
      name: 'Akkawi',
      description:
          'Classic Levantine melted Akkawi cheese manousheh on crisp oven-baked dough.',
      price: 18.00,
      category: 'Picks for you 🔥',
      image:
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=600&q=80',
      imageBgColor: Color(0xFF144B5B),
      isPopular: true,
      optionGroups: [
        MenuItemOptionGroup(
          title: 'Crust Preference',
          isRequired: true,
          options: [
            MenuItemOption(name: 'Regular Oven Baked', isDefault: true),
            MenuItemOption(name: 'Extra Crispy Thin Crust'),
          ],
        ),
        MenuItemOptionGroup(
          title: 'Add-ons',
          maxSelections: 2,
          options: [
            MenuItemOption(name: 'Extra Akkawi Cheese', price: 4.0),
            MenuItemOption(name: 'Add Sesame & Black Seeds', price: 2.0),
          ],
        ),
      ],
    ),
    MenuItem(
      id: 'crispy-supreme',
      name: 'Crispy Supreme',
      description:
          'Crispy golden chicken tenders, melted cheddar, lettuce & secret garlic aioli in warm wrap.',
      price: 32.00,
      category: 'Picks for you 🔥',
      image:
          'https://images.unsplash.com/photo-1626700051175-6818013e1d4f?auto=format&fit=crop&w=600&q=80',
      imageBgColor: Color(0xFFE8DFD8),
      isPopular: true,
      optionGroups: [
        MenuItemOptionGroup(
          title: 'Sauce Choice',
          options: [
            MenuItemOption(name: 'Garlic Aioli Dip', isDefault: true),
            MenuItemOption(name: 'Spicy Dynamite Sauce', price: 3.0),
          ],
        ),
      ],
    ),
    MenuItem(
      id: 'zaatar',
      name: 'Zaatar',
      description:
          'Authentic Lebanese wild thyme, toasted sesame seeds & premium extra virgin olive oil.',
      price: 10.00,
      category: 'Picks for you 🔥',
      image:
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=600&q=80',
      imageBgColor: Color(0xFF144B5B),
      isPopular: true,
      isVegetarian: true,
    ),
    MenuItem(
      id: 'zaatar-x-cheese',
      name: 'Zaatar x Cheese',
      description:
          'Half premium melted Akkawi cheese and half aromatic wild thyme zaatar blend.',
      price: 14.00,
      category: 'Picks for you 🔥',
      image:
          'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?auto=format&fit=crop&w=600&q=80',
      imageBgColor: Color(0xFF144B5B),
      isPopular: true,
      isVegetarian: true,
    ),
    MenuItem(
      id: 'lahem-beajine',
      name: 'Lahem Beajine',
      description:
          'Finely minced spiced lamb & beef with fresh tomatoes, sweet onions & Mediterranean spices.',
      price: 18.00,
      category: 'Picks for you 🔥',
      image:
          'https://images.unsplash.com/photo-1541745537411-b8046dc6d66c?auto=format&fit=crop&w=600&q=80',
      imageBgColor: Color(0xFF144B5B),
      isPopular: true,
    ),
    MenuItem(
      id: 'philly-cheesesteak',
      name: 'Philly Cheesesteak',
      description:
          'Thinly sliced tender ribeye steak, caramelized onions, melted provolone cheese in toasted roll.',
      price: 38.00,
      category: 'Picks for you 🔥',
      image:
          'https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=600&q=80',
      imageBgColor: Color(0xFFE8DFD8),
      isPopular: true,
    ),

    // --- MACRO MADNESS (List Layout with Macros) ---
    MenuItem(
      id: 'chicken58',
      name: 'Chicken58',
      macros: 'P:47g, C:38g , F:19g , Cal:520.',
      description:
          'Grilled chicken breast, light mozzarella, crisp lettuce, tomato & light herb sauce in whole wheat wrap.',
      price: 38.00,
      category: 'Macro Madness',
      image:
          'https://images.unsplash.com/photo-1626700051175-6818013e1d4f?auto=format&fit=crop&w=600&q=80',
      imageBgColor: Color(0xFFF6D6C6),
      isCustomizable: true,
      optionGroups: [
        MenuItemOptionGroup(
          title: 'Wrap Bread',
          isRequired: true,
          options: [
            MenuItemOption(name: 'Whole Wheat Wrap', isDefault: true),
            MenuItemOption(name: 'Spinach Protein Wrap'),
          ],
        ),
      ],
    ),
    MenuItem(
      id: 'hallo-gym',
      name: 'Hallo Gym',
      macros: 'P:32g, C:40g, F:30g, Cal:560.',
      description:
          'Light halloumi, avocado, rocca, sundried tomato, and light pesto spread in oat wrap.',
      price: 36.00,
      category: 'Macro Madness',
      image:
          'https://images.unsplash.com/photo-1509722747041-616f39b57569?auto=format&fit=crop&w=600&q=80',
      imageBgColor: Color(0xFFF9E8B2),
      isVegetarian: true,
      isCustomizable: true,
    ),
    MenuItem(
      id: 'lean-beef-power',
      name: 'Lean Beef Power',
      macros: 'P:52g, C:35g, F:16g, Cal:490.',
      description:
          'Charcoal-grilled lean beef strips, roasted sweet peppers, baby spinach & light tahini drizzle.',
      price: 42.00,
      category: 'Macro Madness',
      image:
          'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=600&q=80',
      imageBgColor: Color(0xFFF6D6C6),
      isCustomizable: true,
    ),
  ],
);
