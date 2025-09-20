import 'package:equatable/equatable.dart';
import '../../../data/models/expense_model.dart';

abstract class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object?> get props => [];
}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseReceiptPicked extends ExpenseState {
  final String receiptPath;

  const ExpenseReceiptPicked(this.receiptPath);

  @override
  List<Object?> get props => [receiptPath];
}

class ExpenseAdded extends ExpenseState {
  final ExpenseModel expense;

  const ExpenseAdded(this.expense);

  @override
  List<Object?> get props => [expense];
}

class ExpenseError extends ExpenseState {
  final String message;

  const ExpenseError(this.message);

  @override
  List<Object?> get props => [message];
}
