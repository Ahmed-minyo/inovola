import 'package:dio/dio.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://v6.exchangerate-api.com/v6/09bc5db2aca37337f530ac68/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Dio get dio => _dio;

  Future<Map<String, dynamic>> getExchangeRates() async {
    try {
      final response = await _dio.get('latest/USD');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch exchange rates: $e');
    }
  }
}
