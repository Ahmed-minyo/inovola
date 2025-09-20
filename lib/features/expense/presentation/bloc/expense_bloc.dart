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
  }

  Future<void> _onAddExpense(
    AddExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseLoading());
    try {
      // Fetch exchange rate
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
      emit(ExpenseAdded(expense));
    } catch (e) {
      emit(ExpenseError('Failed to add expense: $e'));
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
        emit(ExpenseReceiptPicked(image.path));
      }
    } catch (e) {
      emit(ExpenseError('Failed to pick receipt: $e'));
    }
  }

  Future<void> _onResetExpense(
    ResetExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseInitial());
  }
}
