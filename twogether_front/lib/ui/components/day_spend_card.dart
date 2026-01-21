import 'package:flutter/material.dart';
import 'package:twogether_front/models/transaction_model.dart';

class DaySpendCard extends StatelessWidget {
  const DaySpendCard({
    Key? key,
    required this.transactions,
    required this.date,
  }) : super(key: key);

  final List<Transaction> transactions;
  final DateTime date;

  double transactionAmount() {
    if (transactions.isEmpty) return 0.0;

    return transactions
        .map(
          (e) => e.value,
        )
        .reduce(
          (value, element) => value + element,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${date.day}'),
          Text(transactionAmount().toStringAsFixed(2)),
        ],
      ),
    );
  }
}
