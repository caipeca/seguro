import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/insurance_policy_entity.dart';

class PolicyCard extends StatelessWidget {
  final InsurancePolicyEntity policy;
  final VoidCallback? onTap;
  final VoidCallback? onRenew;
  final VoidCallback? onClaim;

  const PolicyCard({
    super.key,
    required this.policy,
    this.onTap,
    this.onRenew,
    this.onClaim,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final daysRemaining = _calculateDaysRemaining();
    final isExpiringSoon = daysRemaining <= 7;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(theme, isExpiringSoon),
              const SizedBox(height: 12),
              _buildPolicyInfo(),
              const SizedBox(height: 16),
              _buildActionButtons(context, isExpiringSoon),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, bool isExpiringSoon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            policy.insurerName,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getPolicyTypeColor(theme),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            policy.type.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPolicyInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('Número da Apólice', policy.id.toString()),
        _buildInfoRow(
          'Validade',
          DateFormat('dd/MM/yyyy').format(policy.expiryDate),
        ),
        _buildDaysRemainingIndicator(),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDaysRemainingIndicator() {
    final daysRemaining = _calculateDaysRemaining();
    final isExpired = daysRemaining < 0;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Icon(
            isExpired ? Icons.warning : Icons.calendar_today,
            size: 16,
            color: isExpired ? Colors.red : Colors.grey,
          ),
          const SizedBox(width: 4),
          Text(
            isExpired
                ? 'Expirado há ${-daysRemaining} dias'
                : 'Vence em $daysRemaining dias',
            style: TextStyle(
              color: isExpired ? Colors.red : Colors.grey,
              fontWeight: isExpired ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isExpiringSoon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (isExpiringSoon)
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: onRenew,
            child: const Text('RENOVAR'),
          ),
        TextButton(
          onPressed: onClaim,
          child: const Text('ACIONAR SINISTRO'),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: onTap,
        ),
      ],
    );
  }

  int _calculateDaysRemaining() {
    return policy.expiryDate.difference(DateTime.now()).inDays;
  }

  Color _getPolicyTypeColor(ThemeData theme) {
    switch (policy.type.toLowerCase()) {
      case 'auto':
        return Colors.blue;
      case 'saúde':
        return Colors.green;
      case 'residencial':
        return Colors.orange;
      case 'vida':
        return Colors.purple;
      default:
        return theme.colorScheme.primary;
    }
  }
}