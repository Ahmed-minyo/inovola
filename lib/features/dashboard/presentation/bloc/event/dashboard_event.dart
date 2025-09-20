import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadDashboard extends DashboardEvent {}

class LoadMoreExpenses extends DashboardEvent {}

class FilterExpenses extends DashboardEvent {
  final String filter;

  const FilterExpenses(this.filter);

  @override
  List<Object?> get props => [filter];
}
