import 'package:equatable/equatable.dart';

abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object?> get props => [];
}

class AddExpense extends ExpenseEvent {
  final String category;
  final double amount;
  final String currency;
  final DateTime date;
  final String? receiptPath;

  const AddExpense({
    required this.category,
    required this.amount,
    required this.currency,
    required this.date,
    this.receiptPath,
  });

  @override
  List<Object?> get props => [category, amount, currency, date, receiptPath];
}

class PickReceipt extends ExpenseEvent {}

class ResetExpense extends ExpenseEvent {}
