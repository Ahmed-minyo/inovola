import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovola/features/expense/presentation/widgets/category_grid.dart';
import 'package:inovola/features/expense/presentation/widgets/date_section.dart';
import 'package:inovola/features/expense/presentation/widgets/amount_section.dart';
import 'package:intl/intl.dart';
import '../../../../utils/index.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../dashboard/presentation/bloc/event/dashboard_event.dart';
import '../bloc/event/expense_event.dart';
import '../bloc/expense_bloc.dart';
import '../bloc/state/expense_state.dart';
import '../widgets/category_section.dart';
import '../widgets/receipt_section.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final bloc = context.read<ExpenseBloc>();
    _dateController.text = DateFormat(
      'MM/dd/yy',
    ).format(bloc.state.selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Add Expense'),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ExpenseBloc, ExpenseState>(
            listener: (context, state) {
              if (state.addedExpense != null) {
                context.read<DashboardBloc>().add(LoadDashboard());
                Navigator.of(context).pop();
                showToast(msg: 'Expense added successfully!');
                context.read<ExpenseBloc>().add(ResetExpense());
              } else if (state.error != null) {
                showToast(msg: state.error!);
              }
            },
          ),
        ],
        child: Form(
          key: _formKey,
          child: BlocBuilder<ExpenseBloc, ExpenseState>(
            builder: (context, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  spacing: 30,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategorySection(selectedCategory: state.selectedCategory),
                    AmountSection(
                      controller: _amountController,
                      value: state.selectedCurrency,
                    ),
                    DateSection(
                      dateController: _dateController,
                      initialDate: state.selectedDate,
                    ),
                    ReceiptSection(receiptPath: state.receiptPath),
                    CategoryGrid(state: state),
                    _buildSaveButton(state),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton(ExpenseState state) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: state.isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.blue))
          : CustomButton(onTap: state.isLoading ? null : _onSave, text: 'Save'),
    );
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(
        _amountController.text.replaceAll('\ ', '').replaceAll(',', ''),
      );

      final bloc = context.read<ExpenseBloc>();
      bloc.add(
        AddExpense(
          category: bloc.state.selectedCategory,
          amount: amount,
          currency: bloc.state.selectedCurrency,
          date: bloc.state.selectedDate,
          receiptPath: bloc.state.receiptPath,
        ),
      );
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
