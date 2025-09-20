import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/index.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/event/dashboard_event.dart';
import '../bloc/state/dashboard_state.dart';

class TopHeader extends StatelessWidget {
  const TopHeader({super.key, required this.state});

  final DashboardLoaded state;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.blueColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  'https://uxwing.com/wp-content/themes/uxwing/download/peoples-avatars/no-profile-picture-icon.png',
                ),
                backgroundColor: Color(0xFFE8F4FD),
              ),
              const Width(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(title: 'Good Morning', isWhite: true),
                    const CustomText(
                      title: 'Shihab Rahman',
                      fontSize: 18,
                      isWhite: true,
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  value: state.currentFilter,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: ['This Month', 'Last 7 Days', 'All Time']
                      .map(
                        (filter) => DropdownMenuItem(
                          value: filter,
                          child: Text(filter),
                        ),
                      )
                      .toList(),
                  onChanged: (filter) {
                    if (filter != null) {
                      context.read<DashboardBloc>().add(FilterExpenses(filter));
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
