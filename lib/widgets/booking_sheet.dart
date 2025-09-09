import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/service.dart';
import '../providers/salon_provider.dart';

class BookingSheet extends StatefulWidget {
  final Service service;
  const BookingSheet({super.key, required this.service});

  @override
  State<BookingSheet> createState() => _BookingSheetState();
}

class _BookingSheetState extends State<BookingSheet> {
  DateTime date = DateTime.now().add(const Duration(days: 1));
  TimeOfDay time = const TimeOfDay(hour: 10, minute: 0);
  String stylist = 'Any';

  @override
  Widget build(BuildContext context) {
    final model = context.read<SalonProvider>();
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child:
                        Container(height: 4, width: 40, color: Colors.black12)),
                const SizedBox(height: 12),
                const Text('Choose Date & Time',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                Row(children: [
                  Expanded(
                      child: OutlinedButton(
                          onPressed: () async {
                            final d = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 90)));
                            if (d != null) setState(() => date = d);
                          },
                          child:
                              Text('${date.day}/${date.month}/${date.year}'))),
                  const SizedBox(width: 12),
                  Expanded(
                      child: OutlinedButton(
                          onPressed: () async {
                            final t = await showTimePicker(
                                context: context, initialTime: time);
                            if (t != null) setState(() => time = t);
                          },
                          child: Text(time.format(context))))
                ]),
                const SizedBox(height: 12),
                const Text('Choose Stylist',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                    spacing: 8,
                    children: ['Any', 'Priya', 'Rahul', 'Neha']
                        .map((s) => ChoiceChip(
                            label: Text(s),
                            selected: stylist == s,
                            onSelected: (_) => setState(() => stylist = s)))
                        .toList()),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {
                      final dt = DateTime(date.year, date.month, date.day,
                          time.hour, time.minute);
                      model.book(widget.service, dt, stylist);
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Appointment booked')));
                    },
                    child: const SizedBox(
                        width: double.infinity,
                        child: Center(child: Text('Confirm Booking')))),
                const SizedBox(height: 8)
              ])),
    );
  }
}
