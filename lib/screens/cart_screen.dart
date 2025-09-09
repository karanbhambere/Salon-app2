import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/salon_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SalonProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Your Bag')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
                child: model.cart.isEmpty
                    ? const Center(child: Text('Your bag is empty'))
                    : ListView.builder(
                        itemCount: model.cart.length,
                        itemBuilder: (ctx, i) {
                          final s = model.cart[i];
                          return ListTile(
                              leading: Image.asset(s.image,
                                  width: 64, height: 64, fit: BoxFit.cover),
                              title: Text(s.title),
                              subtitle: Text('₹${s.price.toStringAsFixed(0)}'),
                              trailing: IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  onPressed: () => model.removeFromCart(s)));
                        })),
            Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.03), blurRadius: 8)
                    ]),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal'),
                        Text('₹${model.subtotal.toStringAsFixed(0)}')
                      ]),
                  const SizedBox(height: 8),
                  ElevatedButton(
                      onPressed: model.cart.isEmpty
                          ? null
                          : () {
                              final dt =
                                  DateTime.now().add(const Duration(days: 2));
                              for (var s in model.cart) {
                                model.book(s, dt, 'Auto-assigned');
                              }
                              model.cart.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Booking confirmed')));
                              Navigator.of(context).pop();
                            },
                      child: const SizedBox(
                          width: double.infinity,
                          child: Center(child: Text('Checkout & Book'))))
                ])),
          ],
        ),
      ),
    );
  }
}
