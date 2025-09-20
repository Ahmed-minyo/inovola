import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovola/features/dashboard/presentation/pages/floating_button.dart';
import '../../../../custom_widgets/bottom_bar.dart';
import '../../../../utils/index.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/event/dashboard_event.dart';
import '../bloc/state/dashboard_state.dart';
import 'balance_card.dart';
import 'expense_item.dart';
import 'recent_see_all.dart';
import 'top_header.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DashboardLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<DashboardBloc>().add(LoadDashboard());
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 320,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                TopHeader(state: state),
                                Positioned(
                                  left: 10,
                                  right: 10,
                                  bottom: -30,
                                  child: BalanceCard(
                                    balance: state.summary['totalBalance'] ?? 0,
                                    income: state.summary['totalIncome'] ?? 0,
                                    expenses:
                                        state.summary['totalExpenses'] ?? 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Height(40),
                          RecentSeeAll(expenses: state.expenses),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index < state.expenses.length) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: ExpenseItem(expense: state.expenses[index]),
                          );
                        } else if (state.hasMoreExpenses) {
                          if (!state.isLoadingMore) {
                            //====future delayed just to see the loader when displaying data and should removed -- I added it for testing===
                            Future.delayed(Duration(seconds: 1)).then(
                              (e) => Future.microtask(() {
                                context.read<DashboardBloc>().add(
                                  LoadMoreExpenses(),
                                );
                              }),
                            );
                          }
                          return const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return null;
                      },
                      childCount: state.hasMoreExpenses
                          ? state.expenses.length + 1
                          : state.expenses.length,
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text('Something went wrong'));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingButton(),
      bottomNavigationBar: BottomBar(),
    );
  }
}
