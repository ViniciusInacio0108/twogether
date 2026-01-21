import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twogether_front/configs/app_routing.dart';
import 'package:twogether_front/controllers/profiles_controller.dart';
import 'package:twogether_front/controllers/months_controller.dart';
import 'package:twogether_front/controllers/transactions_controller.dart';
import 'package:twogether_front/daos/transaction_dao.dart';
import 'package:twogether_front/repositories/transaction_repository.dart';
import 'package:twogether_front/services/transaction_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProfilesController(),
        ),
        ChangeNotifierProvider(
          create: (context) => MonthsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => MonthlyTransactionsController(
            TransactionService(
              TransactionRepositoryImpl(
                TransactionDao(),
                TransactionMapper(),
              ),
            ),
            DateTime.now().year,
            DateTime.now().month,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Twogether',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: MyAppRouting().routes,
      ),
    );
  }
}
