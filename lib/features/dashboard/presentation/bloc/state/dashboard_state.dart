import 'package:equatable/equatable.dart';
import '../../../../expense/data/models/expense_model.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<ExpenseModel> expenses;
  final Map<String, double> summary;
  final String currentFilter;
  final bool hasMoreExpenses;
  final bool isLoadingMore;

  const DashboardLoaded({
    required this.expenses,
    required this.summary,
    this.currentFilter = 'This Month',
    this.hasMoreExpenses = true,
    this.isLoadingMore = false,
  });

  @override
  List<Object?> get props => [
    expenses,
    summary,
    currentFilter,
    hasMoreExpenses,
    isLoadingMore,
  ];

  DashboardLoaded copyWith({
    List<ExpenseModel>? expenses,
    Map<String, double>? summary,
    String? currentFilter,
    bool? hasMoreExpenses,
    bool? isLoadingMore,
  }) {
    return DashboardLoaded(
      expenses: expenses ?? this.expenses,
      summary: summary ?? this.summary,
      currentFilter: currentFilter ?? this.currentFilter,
      hasMoreExpenses: hasMoreExpenses ?? this.hasMoreExpenses,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}
