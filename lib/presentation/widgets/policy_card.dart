import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seguro/domain/entities/insurance_policy_entity.dart';

class PolicyCard extends StatelessWidget {
final InsurancePolicyEntity policy;
  const PolicyCard({super.key, required this.policy});

  @override
  Widget build(BuildContext context) {
    final daysLeft = policy.expiryDate.difference(DateTime.now()).inDays;
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getIconByType(policy.type),
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  policy.insurerName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Tipo: ${policy.type.toUpperCase()}'),
            Text(
              'Vence em: ${DateFormat('dd/MM/yyyy').format(policy.expiryDate)}',
              style: TextStyle(
                color: daysLeft <= 7 ? Colors.red : Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Detalhes'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Renovar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

IconData _getIconByType(String type) {
  switch (type) {
    case 'auto': return Icons.directions_car;
    case 'health': return Icons.medical_services;
    case 'home': return Icons.home;
    default: return Icons.article;
  }
}
}
