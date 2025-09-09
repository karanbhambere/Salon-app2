import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_app2/screens/profile_screen.dart';

import '../providers/salon_provider.dart';
import '../widgets/service_card.dart';
import 'appointments_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  final categories = ['All', 'Hair', 'Nails', 'Spa', 'Makeup'];

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SalonProvider>();
    final services = selectedCategory == 'All'
        ? model.services
        : model.services.where((s) => s.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Aura Salon',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Stack(children: [
              const Icon(Icons.shopping_bag_outlined),
              if (model.cart.isNotEmpty)
                Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.red,
                        child: Text('${model.cart.length}',
                            style: const TextStyle(
                                fontSize: 10, color: Colors.white))))
            ]),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const CartScreen())),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            SizedBox(
                height: 44,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (ctx, i) {
                      final c = categories[i];
                      final active = c == selectedCategory;
                      return ChoiceChip(
                          label: Text(c),
                          selected: active,
                          onSelected: (_) =>
                              setState(() => selectedCategory = c));
                    })),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.74),
                itemCount: services.length,
                itemBuilder: (ctx, i) => ServiceCard(service: services[i]),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: 'Appointments'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
          ],
          currentIndex: 0,
          onTap: (i) {
            if (i == 1) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const AppointmentsScreen()));
            }
            if (i == 2) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ProfileScreen()));
            }
          }),
    );
  }
}
