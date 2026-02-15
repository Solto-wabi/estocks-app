import 'package:flutter/material.dart';
import '../main.dart';
import '../models/donation_model.dart';

class DonationHistoryPage extends StatelessWidget {
  const DonationHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: donationController,
      builder: (context, _) {
        final history = donationController.history.reversed.toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Histórico de Doações'),
            centerTitle: true,
          ),
          body: history.isEmpty
              ? const Center(
                  child: Text(
                    'Nenhuma movimentação registrada',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final donation = history[index];
                    final isEntry =
                        donation.type == DonationType.received;

                    final formattedDate =
                        '${donation.date.day.toString().padLeft(2, '0')}/'
                        '${donation.date.month.toString().padLeft(2, '0')}/'
                        '${donation.date.year}';

                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isEntry
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                          child: Icon(
                            isEntry
                                ? Icons.arrow_downward
                                : Icons.arrow_upward,
                            color: isEntry
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        title: Text(
                          donation.itemName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Qtd: ${donation.quantity}'
                          '${donation.partner != null && donation.partner!.isNotEmpty ? " • ${donation.partner}" : ""}',
                        ),
                        trailing: Text(
                          formattedDate,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
