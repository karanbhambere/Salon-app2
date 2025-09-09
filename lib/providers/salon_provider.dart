import 'package:flutter/material.dart';
import 'package:salon_app2/models/appoiment.dart';

import '../models/service.dart';

class SalonProvider extends ChangeNotifier {
  final List<Service> services;
  final List<Service> cart = [];
  final List<Appointment> appointments = [];

  SalonProvider({required this.services});

  factory SalonProvider.sample() {
    final List<Service> services = [
      Service(
          id: 's1',
          title: 'Classic Haircut',
          category: 'Hair',
          description: 'Classic trim & style',
          price: 399,
          image: 'assets/images/haircut.jpg'),
      Service(
          id: 's2',
          title: 'Keratin Treatment',
          category: 'Hair',
          description: 'Smooth & shiny',
          price: 1599,
          image: 'assets/images/keratin.jpg'),
      Service(
          id: 's3',
          title: 'Manicure',
          category: 'Nails',
          description: 'Polish & shape',
          price: 499,
          image: 'assets/images/manicure.jpg'),
      Service(
          id: 's4',
          title: 'Pedicure',
          category: 'Nails',
          description: 'Foot care & polish',
          price: 599,
          image: 'assets/images/pedicure.jpg'),
      Service(
          id: 's5',
          title: 'Relaxing Spa',
          category: 'Spa',
          description: 'Full body massage',
          price: 1299,
          image: 'assets/images/spa.jpg'),
      Service(
          id: 's6',
          title: 'Bridal Makeup',
          category: 'Makeup',
          description: 'Glam bridal',
          price: 4999,
          image: 'assets/images/makeup.jpg'),
    ];
    return SalonProvider(services: services);
  }

  void addToCart(Service s) {
    cart.add(s);
    notifyListeners();
  }

  void removeFromCart(Service s) {
    cart.remove(s);
    notifyListeners();
  }

  double get subtotal => cart.fold(0.0, (t, s) => t + s.price);

  void book(Service s, DateTime dt, String stylist) {
    appointments.add(Appointment(
        id: 'a${appointments.length + 1}',
        service: s,
        dateTime: dt,
        stylist: stylist));
    notifyListeners();
  }
}
