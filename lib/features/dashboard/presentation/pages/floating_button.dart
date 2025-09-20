import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/index.dart';
import '../../../currency/presentation/bloc/currency_bloc.dart';
import '../../../expense/presentation/bloc/expense_bloc.dart';
import '../../../expense/presentation/pages/add_expense_page.dart';
import '../bloc/dashboard_bloc.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Height(80),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: context.read<ExpenseBloc>()),
                        BlocProvider.value(value: context.read<CurrencyBloc>()),
                        BlocProvider.value(
                          value: context.read<DashboardBloc>(),
                        ),
                      ],
                      child: const AddExpensePage(),
                    ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      // Slide + fade
                      const begin = Offset(1.0, 0.0); // from right
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      var tween = Tween(
                        begin: begin,
                        end: end,
                      ).chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                transitionDuration: const Duration(milliseconds: 400), // speed
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: AppColors.blueColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
