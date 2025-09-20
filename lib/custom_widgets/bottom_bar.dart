import '../utils/index.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BottomBarItem(icons: Icons.home_filled, isActive: true),
          BottomBarItem(icons: Icons.bar_chart),
          const Width(60), // Space for FAB
          BottomBarItem(icons: Icons.credit_card),
          BottomBarItem(icons: Icons.person),
        ],
      ),
    );
  }
}

class BottomBarItem extends StatelessWidget {
  const BottomBarItem({super.key, required this.icons, this.isActive = false});

  final IconData icons;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Icon(
        icons,
        color: isActive ? AppColors.blueColor : Colors.grey,
        size: 28,
      ),
    );
  }
}
