import 'package:equatable/equatable.dart';
import '../../../data/models/expense_model.dart';

class ExpenseState extends Equatable {
  final String selectedCategory;
  final String selectedCurrency;
  final DateTime selectedDate;
  final String? receiptPath;
  final bool isLoading;
  final String? error;
  final ExpenseModel? addedExpense;

  ExpenseState({
    this.selectedCategory = 'Entertainment',
    this.selectedCurrency = 'USD',
    DateTime? selectedDate,
    this.receiptPath,
    this.isLoading = false,
    this.error,
    this.addedExpense,
  }) : selectedDate = selectedDate ?? DateTime.now();

  ExpenseState copyWith({
    String? selectedCategory,
    String? selectedCurrency,
    DateTime? selectedDate,
    String? receiptPath,
    bool? isLoading,
    String? error,
    ExpenseModel? addedExpense,
  }) {
    return ExpenseState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      selectedDate: selectedDate ?? this.selectedDate,
      receiptPath: receiptPath ?? this.receiptPath,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      addedExpense: addedExpense,
    );
  }

  @override
  List<Object?> get props => [
    selectedCategory,
    selectedCurrency,
    selectedDate,
    receiptPath,
    isLoading,
    error,
    addedExpense,
  ];

  @override
  String toString() {
    return 'ExpenseState($selectedCategory, $selectedCurrency, $selectedDate, $receiptPath, $isLoading, $error, $addedExpense)';
  }
}

class ExpenseInitial extends ExpenseState {
  ExpenseInitial()
    : super(
        selectedCategory: 'Entertainment',
        selectedCurrency: 'USD',
        selectedDate: DateTime.now(),
      );

  @override
  String toString() {
    return 'ExpenseInitial($selectedCategory, $selectedCurrency, $selectedDate, $receiptPath, $isLoading, $error, $addedExpense)';
  }
}
