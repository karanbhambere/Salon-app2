import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/service.dart';
import '../providers/salon_provider.dart';
import '../widgets/booking_sheet.dart';

class ServiceDetailScreen extends StatelessWidget {
  final Service service;
  const ServiceDetailScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SalonProvider>();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black87),
      body: Column(children: [
        Image.asset(service.image,
            height: 260, width: double.infinity, fit: BoxFit.cover),
        Expanded(
            child: Container(
                padding: const EdgeInsets.all(18),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(service.title,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text('₹${service.price.toStringAsFixed(0)}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700))
                          ]),
                      const SizedBox(height: 8),
                      Text(service.description,
                          style: const TextStyle(color: Colors.black54)),
                      const Spacer(),
                      Row(children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () => showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20))),
                                    builder: (_) =>
                                        BookingSheet(service: service)),
                                child: const Text('Book Now'))),
                        const SizedBox(width: 12),
                        OutlinedButton(
                            onPressed: () => model.addToCart(service),
                            child: const Text('Add to bag'))
                      ])
                    ])))
      ]),
    );
  }
}
