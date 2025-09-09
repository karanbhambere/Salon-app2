import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/salon_provider.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SalonProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Appointments')),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: model.appointments.isEmpty
              ? const Center(child: Text('No appointments yet'))
              : ListView.builder(
                  itemCount: model.appointments.length,
                  itemBuilder: (ctx, i) {
                    final a = model.appointments[i];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Image.asset(a.service.image,
                            width: 56, height: 56, fit: BoxFit.cover),
                        title: Text(a.service.title),
                        subtitle: Text(
                            '${a.stylist} • ${a.dateTime.day}/${a.dateTime.month}/${a.dateTime.year} ${a.dateTime.hour}:${a.dateTime.minute.toString().padLeft(2, '0')}'),
                        trailing: IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () {}),
                      ),
                    );
                  })),
    );
  }
}
