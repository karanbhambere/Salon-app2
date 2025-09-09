import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_app2/screens/home_screen.dart';

import 'providers/salon_provider.dart';

void main() {
  runApp(const AuraSalonApp());
}

class AuraSalonApp extends StatelessWidget {
  const AuraSalonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SalonProvider.sample(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aura Salon',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
          scaffoldBackgroundColor: const Color(0xFFF6F6FB),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
