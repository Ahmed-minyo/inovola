import '../../../../utils/index.dart';

class BalanceItem extends StatelessWidget {
  const BalanceItem({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
  });
  final String title, amount;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 3,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 4,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.2),
              ),
              child: Icon(icon, color: Colors.white, size: 15),
            ),
            CustomText(title: title, isWhite: true, fontSize: 12),
          ],
        ),
        CustomText(
          title: amount,
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
