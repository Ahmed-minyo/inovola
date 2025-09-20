import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovola/features/expense/presentation/widgets/add_cat_circle.dart';
import 'package:inovola/features/expense/presentation/widgets/date_section.dart';
import 'package:inovola/features/expense/presentation/widgets/amount_section.dart';
import 'package:intl/intl.dart';
import '../../data/models/category_model.dart';
import '../../../../utils/index.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../dashboard/presentation/bloc/event/dashboard_event.dart';
import '../bloc/event/expense_event.dart';
import '../bloc/expense_bloc.dart';
import '../bloc/state/expense_state.dart';
import '../widgets/custom_head_title.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();

  String _selectedCategory = 'Entertainment';
  String _selectedCurrency = 'USD';
  DateTime _selectedDate = DateTime.now();
  String? _receiptPath;

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('MM/dd/yy').format(_selectedDate);
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
              if (state is ExpenseAdded) {
                context.read<DashboardBloc>().add(LoadDashboard());
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Expense added successfully!')),
                );
              } else if (state is ExpenseReceiptPicked) {
                setState(() {
                  _receiptPath = state.receiptPath;
                });
              } else if (state is ExpenseError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
        ],
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategorySection(),
                const Height(30),
                AmountSection(
                  controller: _amountController,
                  value: _selectedCurrency,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedCurrency = value;
                      });
                    }
                  },
                ),
                const Height(30),
                DateSection(
                  dateController: _dateController,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      setState(() {
                        _selectedDate = date;
                        _dateController.text = DateFormat(
                          'MM/dd/yy',
                        ).format(date);
                      });
                    }
                  },
                ),
                const Height(30),
                _buildReceiptSection(),
                const Height(30),
                _buildCategoryGrid(),
                const Height(40),
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(title: 'Categories', fontSize: 16),
        const Height(12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.greyColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: _selectedCategory,
            isExpanded: true,
            underline: const SizedBox(),
            items: categoriesList
                .map(
                  (category) => DropdownMenuItem<String>(
                    value: category.name,
                    child: Row(
                      children: [
                        Icon(category.icons, color: category.color, size: 20),
                        const Width(8),
                        CustomText(title: category.name),
                      ],
                    ),
                  ),
                )
                .toList(),
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 40),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedCategory = value;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReceiptSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomHeadTitle(title: 'Attach Receipt'),
        const Height(12),
        GestureDetector(
          onTap: () {
            context.read<ExpenseBloc>().add(PickReceipt());
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: _receiptPath != null
                ? Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(_receiptPath!),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Width(12),
                      const Expanded(
                        child: CustomText(title: 'Receipt attached'),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _receiptPath = null;
                          });
                        },
                        icon: const Icon(Icons.close, color: Colors.grey),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        title: 'Upload image',
                        fontSize: 12,
                        color: AppColors.hintColor,
                        fontWeight: FontWeight.w400,
                      ),
                      Icon(
                        Icons.video_camera_front_outlined,
                        color: Colors.black87,
                        size: 24,
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomHeadTitle(title: 'Categories'),
        const Height(12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemCount: categoriesList.length + 1,
          itemBuilder: (context, index) {
            if (index < categoriesList.length) {
              final category = categoriesList[index];
              final isSelected = category.name == _selectedCategory;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategory = category.name;
                  });
                },
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? category.color.withOpacity(0.2)
                            : Colors.grey[100],
                        // borderRadius: BorderRadius.circular(12),
                        border: isSelected
                            ? Border.all(color: category.color, width: 2)
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            category.icons,
                            color: isSelected
                                ? category.color
                                : Colors.grey[600],
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                    const Height(4),
                    CustomText(
                      title: category.name,
                      fontSize: 10,
                      color: isSelected ? AppColors.blueColor : Colors.black,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else {
              return AddCatCircle();
            }
          },
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 56,
          child: state is ExpenseLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : CustomButton(
                  onTap: state is ExpenseLoading ? null : _onSave,
                  text: 'Save',
                ),
        );
      },
    );
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(
        _amountController.text.replaceAll('\ ', '').replaceAll(',', ''),
      );

      context.read<ExpenseBloc>().add(
        AddExpense(
          category: _selectedCategory,
          amount: amount,
          currency: _selectedCurrency,
          date: _selectedDate,
          receiptPath: _receiptPath,
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
