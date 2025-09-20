import 'package:equatable/equatable.dart';

class ExpenseModel extends Equatable {
  final int? id;
  final String category;
  final double amount;
  final double originalAmount;
  final String currency;
  final DateTime date;
  final String? receiptPath;
  final DateTime createdAt;

  const ExpenseModel({
    this.id,
    required this.category,
    required this.amount,
    required this.originalAmount,
    required this.currency,
    required this.date,
    this.receiptPath,
    required this.createdAt,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      category: json['category'],
      amount: json['amount'].toDouble(),
      originalAmount: json['originalAmount'].toDouble(),
      currency: json['currency'],
      date: DateTime.parse(json['date']),
      receiptPath: json['receiptPath'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'originalAmount': originalAmount,
      'currency': currency,
      'date': date.toIso8601String(),
      'receiptPath': receiptPath,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    category,
    amount,
    originalAmount,
    currency,
    date,
    receiptPath,
    createdAt,
  ];
}
