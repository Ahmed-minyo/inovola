import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/database/database_helper.dart';
import 'features/currency/presentation/bloc/event/currency_event.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/dashboard/presentation/bloc/event/dashboard_event.dart';
import 'features/expense/presentation/bloc/expense_bloc.dart';
import 'features/currency/presentation/bloc/currency_bloc.dart';
import 'features/dashboard/presentation/widgets/dashboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardBloc>(
          create: (context) => DashboardBloc()..add(LoadDashboard()),
        ),
        BlocProvider<ExpenseBloc>(create: (context) => ExpenseBloc()),
        BlocProvider<CurrencyBloc>(
          create: (context) => CurrencyBloc()..add(LoadCurrencies()),
        ),
      ],
      child: MaterialApp(
        title: "Inovola Task",
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const DashboardPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
