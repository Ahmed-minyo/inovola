import 'package:intl/intl.dart';
import '../../../../utils/index.dart';
import '../../../expense/data/models/expense_model.dart';

class ExpenseItem extends StatelessWidget {
  final ExpenseModel expense;

  const ExpenseItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(symbol: '\ ', decimalDigits: 2);
    final dateFormatter = DateFormat('MMM dd, yyyy');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getCategoryColor(expense.category).withValues(alpha: 0.1),
            ),
            child: Icon(
              _getCategoryIcon(expense.category),
              color: _getCategoryColor(expense.category),
              size: 24,
            ),
          ),
          const Width(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: expense.category,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const Height(4),
                Row(
                  children: [
                    CustomText(
                      title: 'Manually',
                      fontSize: 12,
                      color: Colors.black38,
                    ),
                    const Width(8),
                    CustomText(
                      title: dateFormatter.format(expense.date),
                      fontSize: 12,
                      color: Colors.black38,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText(
                title: '- ${formatter.format(expense.amount)}',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              if (expense.currency != 'USD')
                CustomText(
                  title:
                      '${expense.originalAmount.toStringAsFixed(2)} ${expense.currency}',
                  fontSize: 12,
                  color: Colors.black38,
                ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'groceries':
        return Icons.shopping_cart;
      case 'entertainment':
        return Icons.movie;
      case 'transport':
        return Icons.directions_car;
      case 'rent':
        return Icons.home;
      case 'gas':
        return Icons.local_gas_station;
      case 'shopping':
        return Icons.shopping_bag;
      case 'news paper':
        return Icons.newspaper;
      default:
        return Icons.category;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'groceries':
        return Colors.blue;
      case 'entertainment':
        return Colors.orange;
      case 'transport':
        return Colors.purple;
      case 'rent':
        return Colors.green;
      case 'gas':
        return Colors.red;
      case 'shopping':
        return Colors.pink;
      case 'news paper':
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }
}
