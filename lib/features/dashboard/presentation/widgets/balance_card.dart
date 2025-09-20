import 'package:intl/intl.dart';
import '../../../../utils/index.dart';
import 'balance_item.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final double income;
  final double expenses;

  const BalanceCard({
    super.key,
    required this.balance,
    required this.income,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.lightBlueColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A90E2).withValues(alpha: 0.3),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CustomText(
                title: 'Total Balance',
                isWhite: true,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              Icon(Icons.keyboard_arrow_up_sharp, color: Colors.white),
              Spacer(),
              Icon(Icons.more_horiz, color: Colors.white),
            ],
          ),
          const Height(8),
          CustomText(
            title: formatter.format(balance),
            isWhite: true,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          const Height(24),
          Row(
            spacing: 24,
            children: [
              Expanded(
                child: BalanceItem(
                  title: 'Income',
                  amount: formatter.format(income),
                  icon: Icons.arrow_downward,
                ),
              ),
              Expanded(
                child: BalanceItem(
                  title: 'Expenses',
                  amount: formatter.format(expenses),
                  icon: Icons.arrow_upward,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
