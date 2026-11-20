import 'store_models.dart';

const sampleStore = Store(
  name: "Luca's Kitchen",
  tagline: 'Artisanal smash burgers & gourmet comfort food',
  cuisine: 'Burgers · American · Comfort food · Shakes',
  rating: 4.8,
  reviewCount: 2450,
  deliveryMinutes: '25–35 min',
  pickupMinutes: '10–15 min',
  deliveryFee: 5.0,
  minimumOrder: 20.0,
  address: 'Business Bay, Dubai',
  distanceKm: 2.4,
  heroImage:
      'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=1200&q=80',
  logoImage:
      'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=300&q=80',
  openingHours: '11:00 AM – 2:00 AM Daily',
  hygieneScore: 'Grade A · Approved by Dubai Municipality',
  categories: [
    'Popular',
    'Burgers',
    'Bowls',
    'Sides',
    'Drinks',
  ],
  offers: [
    StoreOffer(
      id: 'offer-1',
      title: 'AED 15 OFF your order',
      subtitle: 'Min. spend AED 60 · Code applied',
      code: 'LUCA15',
      minSpend: 60.0,
      discountAmount: 15.0,
    ),
    StoreOffer(
      id: 'offer-2',
      title: 'Free Delivery with Kuicko Pro',
      subtitle: 'Orders above AED 45 qualify for free delivery',
      code: 'FREEDEL',
      minSpend: 45.0,
      discountAmount: 5.0,
    ),
    StoreOffer(
      id: 'offer-3',
      title: '20% OFF on Bestseller Combos',
      subtitle: 'Valid on Burgers & Combos · Limited time',
      code: 'BURGER20',
      minSpend: 50.0,
      discountAmount: 12.0,
    ),
  ],
  menuItems: [
    MenuItem(
      id: 'classic-smash',
      name: 'Classic Smash',
      description:
          'Double smashed Angus beef patties, melted American cheddar, dill pickles, grilled sweet onions & secret house sauce on a toasted brioche bun.',
      price: 42.0,
      originalPrice: 48.0,
      category: 'Burgers',
      image:
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=600&q=80',
      isPopular: true,
      calories: 680,
      optionGroups: [
        MenuItemOptionGroup(
          title: 'Choice of Bun',
          isRequired: true,
          options: [
            MenuItemOption(name: 'Toasted Brioche Bun', isDefault: true),
            MenuItemOption(name: 'Sesame Potato Bun'),
            MenuItemOption(name: 'Lettuce Wrap (Keto/Low-carb)'),
          ],
        ),
        MenuItemOptionGroup(
          title: 'Add Extras & Toppings',
          maxSelections: 3,
          options: [
            MenuItemOption(name: 'Extra Cheddar Cheese Slice', price: 4.0),
            MenuItemOption(name: 'Crispy Veal Bacon Strips', price: 7.0),
            MenuItemOption(name: 'Caramelized Onions', price: 3.0),
            MenuItemOption(name: 'Jalapeño Peppers', price: 3.0),
          ],
        ),
      ],
    ),
    MenuItem(
      id: 'truffle-mushroom',
      name: 'Truffle Mushroom',
      description:
          'Two Angus beef smash patties topped with sautéed wild portobello mushrooms, Swiss Gruyère cheese & creamy black truffle garlic mayo.',
      price: 49.0,
      category: 'Burgers',
      image:
          'https://images.unsplash.com/photo-1553979459-d2229ba7433a?auto=format&fit=crop&w=600&q=80',
      isPopular: true,
      calories: 740,
      optionGroups: [
        MenuItemOptionGroup(
          title: 'Choice of Bun',
          isRequired: true,
          options: [
            MenuItemOption(name: 'Toasted Brioche Bun', isDefault: true),
            MenuItemOption(name: 'Sesame Bun'),
          ],
        ),
        MenuItemOptionGroup(
          title: 'Extra Sauces',
          maxSelections: 2,
          options: [
            MenuItemOption(name: 'Extra Black Truffle Mayo Dip', price: 5.0),
            MenuItemOption(name: 'Garlic Aioli Dip', price: 4.0),
          ],
        ),
      ],
    ),
    MenuItem(
      id: 'crispy-chicken',
      name: 'Crispy Chicken Sando',
      description:
          'Buttermilk fried tender chicken breast dipped in spicy glaze, topped with creamy cider slaw, pickled gherkins & house sauce.',
      price: 39.0,
      originalPrice: 44.0,
      category: 'Burgers',
      image:
          'https://images.unsplash.com/photo-1606755962773-d324e0a13086?auto=format&fit=crop&w=600&q=80',
      isPopular: false,
      isSpicy: true,
      calories: 650,
    ),
    MenuItem(
      id: 'green-goddess',
      name: 'Green Goddess Bowl',
      description:
          'Fresh Hass avocado slices, organic tri-color quinoa, baby spinach, steamed edamame, Persian cucumbers, toasted pumpkin seeds with green herb dressing.',
      price: 36.0,
      category: 'Bowls',
      image:
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=600&q=80',
      isPopular: true,
      isVegetarian: true,
      calories: 420,
      optionGroups: [
        MenuItemOptionGroup(
          title: 'Add Protein',
          maxSelections: 1,
          options: [
            MenuItemOption(name: 'No Extra Protein', isDefault: true),
            MenuItemOption(name: 'Grilled Herb Chicken (+AED 10)', price: 10.0),
            MenuItemOption(name: 'Pan-seared Halloumi (+AED 8)', price: 8.0),
          ],
        ),
      ],
    ),
    MenuItem(
      id: 'loaded-fries',
      name: 'Luca’s Loaded Fries',
      description:
          'Crispy golden fries tossed in house seasoning, drenched in warm artisanal melted cheddar sauce, spring onions & house dip.',
      price: 24.0,
      category: 'Sides',
      image:
          'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?auto=format&fit=crop&w=600&q=80',
      isVegetarian: true,
      calories: 420,
    ),
    MenuItem(
      id: 'fresh-lemonade',
      name: 'Fresh Lemonade',
      description:
          'Cold-pressed Mediterranean lemons, organic cane sugar, crushed ice & a hint of fresh garden mint.',
      price: 16.0,
      category: 'Drinks',
      image:
          'https://images.unsplash.com/photo-1513558161293-cdad765edc89?auto=format&fit=crop&w=600&q=80',
      isVegetarian: true,
      calories: 140,
    ),
  ],
);
