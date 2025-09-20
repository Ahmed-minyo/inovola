import '../../../../utils/index.dart';

class RecentSeeAll extends StatelessWidget {
  const RecentSeeAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomText(
            title: 'Recent Expenses',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          TextButton(
            onPressed: () {},
            child: const CustomText(title: 'see all'),
          ),
        ],
      ),
    );
  }
}
