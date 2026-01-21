import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twogether_front/controllers/profiles_controller.dart';
import 'package:twogether_front/controllers/months_controller.dart';
import 'package:twogether_front/controllers/transactions_controller.dart';
import 'package:twogether_front/enums/Etransaction_types.dart';
import 'package:twogether_front/models/transaction_model.dart';
import 'package:twogether_front/ui/components/day_spend_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<void> _onTapCard(BuildContext context, int index) async {
    final ownerId = context.read<ProfilesController>().currentSelectedUser?.id;

    if (ownerId == null) return;

    // based on the card
    final date = DateTime(2026, 1, index + 1);

    final transaction = Transaction(
      value: 22.0,
      ownerId: ownerId,
      type: EtransactionTypes.income,
      date: date,
    );
    context.read<MonthlyTransactionsController>().addTransaction(transaction);
  }

  @override
  Widget build(BuildContext context) {
    final selectedProfileName =
        context.watch<ProfilesController>().currentSelectedUser?.name;
    final homeCtrl = context.watch<MonthsController>();
    final transactionCtrl = context.watch<MonthlyTransactionsController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Olá, $selectedProfileName!"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Meu saldo"),
                  const SizedBox(height: 12),
                  const Text("R\$ 30,00"),
                  const SizedBox(height: 12),
                  // Month navigator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: homeCtrl.prevMonth,
                        icon: const Icon(Icons.chevron_left),
                      ),
                      Text(
                        homeCtrl.visibleMonthLabel,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: homeCtrl.nextMonth,
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Days list
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.separated(
                  itemCount: homeCtrl.daysInVisibleMonth,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final dayNumber = index + 1;
                    final date = DateTime(homeCtrl.visibleMonth.year,
                        homeCtrl.visibleMonth.month, dayNumber);

                    return InkWell(
                      onTap: () => _onTapCard(context, index),
                      child: DaySpendCard(
                        date: date,
                        transactions: transactionCtrl.byDay[date] ?? [],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
