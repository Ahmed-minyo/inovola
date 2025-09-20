import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovola/features/dashboard/presentation/bloc/state/dashboard_state.dart';
import '../../../../core/database/database_helper.dart';
import 'event/dashboard_event.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  DashboardBloc() : super(DashboardInitial()) {
    on<LoadDashboard>(_onLoadDashboard);
    on<LoadMoreExpenses>(_onLoadMoreExpenses);
    on<FilterExpenses>(_onFilterExpenses);
  }

  Future<void> _onLoadDashboard(
    LoadDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    try {
      final expenses = await _databaseHelper.getExpenses(
        limit: 10,
        offset: 0,
        filter: 'This Month',
      );
      final summary = await _databaseHelper.getSummary(filter: 'This Month');

      emit(
        DashboardLoaded(
          expenses: expenses,
          summary: summary,
          currentFilter: 'This Month',
          hasMoreExpenses: expenses.length == 10,
        ),
      );
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }

  Future<void> _onLoadMoreExpenses(
    LoadMoreExpenses event,
    Emitter<DashboardState> emit,
  ) async {
    if (state is DashboardLoaded) {
      final currentState = state as DashboardLoaded;
      if (currentState.isLoadingMore || !currentState.hasMoreExpenses) return;

      emit(currentState.copyWith(isLoadingMore: true));

      try {
        final moreExpenses = await _databaseHelper.getExpenses(
          limit: 10,
          offset: currentState.expenses.length,
          filter: currentState.currentFilter,
        );

        emit(
          currentState.copyWith(
            expenses: [...currentState.expenses, ...moreExpenses],
            hasMoreExpenses: moreExpenses.length == 10,
            isLoadingMore: false,
          ),
        );
      } catch (e) {
        emit(currentState.copyWith(isLoadingMore: false));
      }
    }
  }

  Future<void> _onFilterExpenses(
    FilterExpenses event,
    Emitter<DashboardState> emit,
  ) async {
    if (state is DashboardLoaded) {
      final currentState = state as DashboardLoaded;
      emit(currentState.copyWith(isLoadingMore: true));

      try {
        final expenses = await _databaseHelper.getExpenses(
          limit: 10,
          offset: 0,
          filter: event.filter,
        );
        final summary = await _databaseHelper.getSummary(filter: event.filter);

        emit(
          DashboardLoaded(
            expenses: expenses,
            summary: summary,
            currentFilter: event.filter,
            hasMoreExpenses: expenses.length == 10,
          ),
        );
      } catch (e) {
        emit(DashboardError(e.toString()));
      }
    }
  }
}
