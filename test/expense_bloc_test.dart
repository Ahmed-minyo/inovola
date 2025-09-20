import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inovola/features/expense/presentation/bloc/expense_bloc.dart';
import 'package:inovola/features/expense/presentation/bloc/event/expense_event.dart';
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
      expect(expenseBloc.state, isA<ExpenseInitial>());
      expect(expenseBloc.state.toString(), startsWith('ExpenseInitial'));
    });

    blocTest<ExpenseBloc, ExpenseState>(
      'ResetExpense emits ExpenseInitial',
      build: () => ExpenseBloc(),
      act: (bloc) => bloc.add(ResetExpense()),
      expect: () => [isA<ExpenseInitial>()],
    );

    blocTest<ExpenseBloc, ExpenseState>(
      'UpdateCategory updates selectedCategory',
      build: () => ExpenseBloc(),
      act: (bloc) => bloc.add(UpdateCategory('Food')),
      expect: () => [
        isA<ExpenseState>().having(
          (state) => state.selectedCategory,
          'selectedCategory',
          'Food',
        ),
      ],
    );

    blocTest<ExpenseBloc, ExpenseState>(
      'UpdateCurrency updates selectedCurrency',
      build: () => ExpenseBloc(),
      act: (bloc) => bloc.add(UpdateCurrency('EUR')),
      expect: () => [
        isA<ExpenseState>().having(
          (state) => state.selectedCurrency,
          'selectedCurrency',
          'EUR',
        ),
      ],
    );

    blocTest<ExpenseBloc, ExpenseState>(
      'UpdateDate updates selectedDate',
      build: () => ExpenseBloc(),
      act: (bloc) {
        final newDate = DateTime(2025, 1, 1);
        bloc.add(UpdateDate(newDate));
      },
      expect: () => [
        isA<ExpenseState>().having(
          (state) => state.selectedDate,
          'selectedDate',
          DateTime(2025, 1, 1),
        ),
      ],
    );
  });
}
