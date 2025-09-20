import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inovola/features/expense/presentation/bloc/state/expense_state.dart';
import '../../data/models/expense_model.dart';
import '../../../../core/database/database_helper.dart';
import '../../../../core/network/api_client.dart';
import 'event/expense_event.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  final ApiClient _apiClient = ApiClient();
  final ImagePicker _imagePicker = ImagePicker();

  ExpenseBloc() : super(ExpenseInitial()) {
    on<AddExpense>(_onAddExpense);
    on<PickReceipt>(_onPickReceipt);
    on<ResetExpense>(_onResetExpense);
    on<UpdateCategory>(_onUpdateCategory);
    on<UpdateCurrency>(_onUpdateCurrency);
    on<UpdateDate>(_onUpdateDate);
  }

  Future<void> _onAddExpense(
    AddExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      double convertedAmount = event.amount;
      if (event.currency != 'USD') {
        final exchangeData = await _apiClient.getExchangeRates();
        final rates = exchangeData['conversion_rates'] as Map<String, dynamic>;
        final rate = rates[event.currency]?.toDouble() ?? 1.0;
        convertedAmount = event.amount / rate;
      }

      final expense = ExpenseModel(
        category: event.category,
        amount: convertedAmount,
        originalAmount: event.amount,
        currency: event.currency,
        date: event.date,
        receiptPath: event.receiptPath,
        createdAt: DateTime.now(),
      );

      await _databaseHelper.insertExpense(expense);

      emit(state.copyWith(isLoading: false, addedExpense: expense));
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, error: 'Failed to add expense: $e'),
      );
    }
  }

  Future<void> _onPickReceipt(
    PickReceipt event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        emit(state.copyWith(receiptPath: image.path));
      }
    } catch (e) {
      emit(state.copyWith(error: 'Failed to pick receipt: $e'));
    }
  }

  Future<void> _onResetExpense(
    ResetExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseInitial());
  }

  void _onUpdateCategory(UpdateCategory event, Emitter<ExpenseState> emit) {
    emit(state.copyWith(selectedCategory: event.category));
  }

  void _onUpdateCurrency(UpdateCurrency event, Emitter<ExpenseState> emit) {
    emit(state.copyWith(selectedCurrency: event.currency));
  }

  void _onUpdateDate(UpdateDate event, Emitter<ExpenseState> emit) {
    emit(state.copyWith(selectedDate: event.date));
  }
}
