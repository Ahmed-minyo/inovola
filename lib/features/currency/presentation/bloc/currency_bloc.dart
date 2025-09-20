import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovola/features/currency/presentation/bloc/state/currency_state.dart';
import '../../../../core/network/api_client.dart';
import 'event/currency_event.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final ApiClient _apiClient = ApiClient();

  CurrencyBloc() : super(CurrencyInitial()) {
    on<LoadCurrencies>(_onLoadCurrencies);
  }

  Future<void> _onLoadCurrencies(
    LoadCurrencies event,
    Emitter<CurrencyState> emit,
  ) async {
    emit(CurrencyLoading());
    try {
      final exchangeData = await _apiClient.getExchangeRates();
      final rates = exchangeData['conversion_rates'] as Map<String, dynamic>;
      final currencies = rates.keys.toList()..sort();

      emit(CurrencyLoaded(currencies));
    } catch (e) {
      // Fallback currencies if API fails
      final fallbackCurrencies = [
        'USD',
        'EUR',
        'GBP',
        'JPY',
        'CAD',
        'AUD',
        'CHF',
        'CNY',
      ];
      emit(CurrencyLoaded(fallbackCurrencies));
    }
  }
}
