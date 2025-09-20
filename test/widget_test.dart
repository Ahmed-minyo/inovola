import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovola/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:inovola/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:inovola/features/expense/presentation/bloc/expense_bloc.dart';
import 'package:inovola/features/currency/presentation/bloc/currency_bloc.dart';

void main() {
  group('Dashboard Widget Tests', () {
    testWidgets('Dashboard shows floating action button', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<DashboardBloc>(create: (context) => DashboardBloc()),
              BlocProvider<ExpenseBloc>(create: (context) => ExpenseBloc()),
              BlocProvider<CurrencyBloc>(create: (context) => CurrencyBloc()),
            ],
            child: const DashboardPage(),
          ),
        ),
      );

      await tester.pump();

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('Dashboard has correct background color', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<DashboardBloc>(create: (context) => DashboardBloc()),
              BlocProvider<ExpenseBloc>(create: (context) => ExpenseBloc()),
              BlocProvider<CurrencyBloc>(create: (context) => CurrencyBloc()),
            ],
            child: const DashboardPage(),
          ),
        ),
      );

      await tester.pump();

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, equals(const Color(0xFFF5F7FA)));
    });
  });
}
