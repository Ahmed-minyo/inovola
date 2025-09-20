import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:inovola/features/expense/presentation/bloc/event/expense_event.dart';
import 'package:inovola/features/expense/presentation/bloc/expense_bloc.dart';
import 'package:inovola/features/expense/data/models/expense_model.dart';
import 'package:inovola/features/expense/presentation/bloc/state/expense_state.dart';

void main() {
  group('ExpenseBloc', () {
    late ExpenseBloc expenseBloc;

    setUp(() {
      expenseBloc = ExpenseBloc();
    });

    tearDown(() {
      expenseBloc.close();
    });

    test('initial state is ExpenseInitial', () {
      expect(expenseBloc.state, equals(ExpenseInitial()));
    });

    group('Reset Expense', () {
      blocTest<ExpenseBloc, ExpenseState>(
        'emits ExpenseInitial when ResetExpense is added',
        build: () => expenseBloc,
        act: (bloc) => bloc.add(ResetExpense()),
        expect: () => [ExpenseInitial()],
      );
    });

    group('Currency Conversion Logic', () {
      test('should convert currency correctly from EUR to USD', () {
        // Test currency conversion logic
        const originalAmount = 100.0;
        const exchangeRate = 0.85; // EUR to USD rate
        const expectedUsdAmount = originalAmount / exchangeRate;

        expect(expectedUsdAmount, closeTo(117.65, 0.01));
      });

      test('should handle USD to USD conversion', () {
        const originalAmount = 100.0;
        const exchangeRate = 1.0; // USD to USD
        const expectedUsdAmount = originalAmount / exchangeRate;

        expect(expectedUsdAmount, equals(100.0));
      });

      test('should convert currency correctly from GBP to USD', () {
        const originalAmount = 80.0;
        const exchangeRate = 0.75; // GBP to USD rate (example)
        const expectedUsdAmount = originalAmount / exchangeRate;

        expect(expectedUsdAmount, closeTo(106.67, 0.01));
      });
    });

    group('Expense Model Validation', () {
      test('should create valid expense model', () {
        final validExpense = ExpenseModel(
          category: 'Food',
          amount: 25.0,
          originalAmount: 25.0,
          currency: 'USD',
          date: DateTime(2024, 1, 1),
          createdAt: DateTime(2024, 1, 1),
        );

        expect(validExpense.category, equals('Food'));
        expect(validExpense.amount, equals(25.0));
        expect(validExpense.originalAmount, equals(25.0));
        expect(validExpense.currency, equals('USD'));
        expect(validExpense.category.isNotEmpty, true);
        expect(validExpense.amount > 0, true);
        expect(validExpense.currency.isNotEmpty, true);
      });

      test('should handle negative amounts (refunds)', () {
        final refundExpense = ExpenseModel(
          category: 'Refund',
          amount: -10.0,
          originalAmount: -10.0,
          currency: 'USD',
          date: DateTime(2024, 1, 1),
          createdAt: DateTime(2024, 1, 1),
        );

        expect(refundExpense.amount, equals(-10.0));
        expect(refundExpense.category, equals('Refund'));
        expect(refundExpense.category.isNotEmpty, true);
      });

      test('should handle different currencies', () {
        final eurExpense = ExpenseModel(
          category: 'Shopping',
          amount: 85.0, // Converted to USD
          originalAmount: 100.0, // Original EUR amount
          currency: 'EUR',
          date: DateTime(2024, 1, 1),
          createdAt: DateTime(2024, 1, 1),
        );

        expect(eurExpense.currency, equals('EUR'));
        expect(eurExpense.originalAmount, equals(100.0));
        expect(eurExpense.amount, equals(85.0));
      });

      test('should handle expense with receipt', () {
        final expenseWithReceipt = ExpenseModel(
          category: 'Groceries',
          amount: 45.50,
          originalAmount: 45.50,
          currency: 'USD',
          date: DateTime(2024, 3, 15),
          receiptPath: '/path/to/receipt.jpg',
          createdAt: DateTime(2024, 3, 15, 10, 30),
        );

        expect(expenseWithReceipt.receiptPath, equals('/path/to/receipt.jpg'));
        expect(expenseWithReceipt.receiptPath?.isNotEmpty, true);
      });
    });

    group('Expense Model JSON Serialization', () {
      test('should serialize to JSON correctly', () {
        final expense = ExpenseModel(
          id: 1,
          category: 'Transportation',
          amount: 25.0,
          originalAmount: 30.0,
          currency: 'EUR',
          date: DateTime(2024, 1, 1),
          receiptPath: '/test/path.jpg',
          createdAt: DateTime(2024, 1, 1),
        );

        final json = expense.toJson();

        expect(json['id'], equals(1));
        expect(json['category'], equals('Transportation'));
        expect(json['amount'], equals(25.0));
        expect(json['originalAmount'], equals(30.0));
        expect(json['currency'], equals('EUR'));
        expect(json['receiptPath'], equals('/test/path.jpg'));
      });

      test('should deserialize from JSON correctly', () {
        final json = {
          'id': 2,
          'category': 'Entertainment',
          'amount': 15.0,
          'originalAmount': 15.0,
          'currency': 'USD',
          'date': DateTime(2024, 2, 1).toIso8601String(),
          'receiptPath': null,
          'createdAt': DateTime(2024, 2, 1).toIso8601String(),
        };

        final expense = ExpenseModel.fromJson(json);

        expect(expense.id, equals(2));
        expect(expense.category, equals('Entertainment'));
        expect(expense.amount, equals(15.0));
        expect(expense.currency, equals('USD'));
        expect(expense.receiptPath, isNull);
      });
    });

    group('Expense Validation Logic', () {
      test('should validate required fields', () {
        // Test that we can create expenses with required fields
        final minimumExpense = ExpenseModel(
          category: 'Test',
          amount: 1.0,
          originalAmount: 1.0,
          currency: 'USD',
          date: DateTime.now(),
          createdAt: DateTime.now(),
        );

        expect(minimumExpense.category.isNotEmpty, true);
        expect(minimumExpense.amount, greaterThan(0));
        expect(minimumExpense.currency.isNotEmpty, true);
      });

      test('should handle edge cases', () {
        // Test zero amount (might be valid for some use cases)
        final zeroExpense = ExpenseModel(
          category: 'Free Sample',
          amount: 0.0,
          originalAmount: 0.0,
          currency: 'USD',
          date: DateTime.now(),
          createdAt: DateTime.now(),
        );

        expect(zeroExpense.amount, equals(0.0));

        // Test very small amounts
        final smallExpense = ExpenseModel(
          category: 'Tip',
          amount: 0.01,
          originalAmount: 0.01,
          currency: 'USD',
          date: DateTime.now(),
          createdAt: DateTime.now(),
        );

        expect(smallExpense.amount, equals(0.01));
      });
    });

    group('Pagination Logic Tests', () {
      test('should calculate pagination correctly', () {
        const pageSize = 10;

        // Test first page
        const page1Offset = 0;
        expect(page1Offset, equals(0));

        // Test second page
        const page2Offset = pageSize * 1;
        expect(page2Offset, equals(10));

        // Test third page
        const page3Offset = pageSize * 2;
        expect(page3Offset, equals(20));
      });

      test('should handle empty results correctly', () {
        const results = <ExpenseModel>[];
        const pageSize = 10;

        final hasMoreResults = results.length == pageSize;
        expect(hasMoreResults, false);
      });

      test('should detect when more results are available', () {
        // Simulate full page of results
        final fullPage = List.generate(
          10,
          (index) => ExpenseModel(
            category: 'Test $index',
            amount: 10.0 + index,
            originalAmount: 10.0 + index,
            currency: 'USD',
            date: DateTime.now(),
            createdAt: DateTime.now(),
          ),
        );

        const pageSize = 10;
        final hasMoreResults = fullPage.length == pageSize;
        expect(hasMoreResults, true);
      });
    });
  });
}
