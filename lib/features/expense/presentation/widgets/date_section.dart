import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../utils/index.dart';
import '../bloc/event/expense_event.dart';
import '../bloc/expense_bloc.dart';
import 'custom_head_title.dart';

class DateSection extends StatelessWidget {
  const DateSection({
    super.key,
    required this.dateController,
    this.initialDate,
  });

  final TextEditingController dateController;
  final DateTime? initialDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomHeadTitle(title: 'Date'),

        const Height(12),
        TextFormField(
          controller: dateController,
          readOnly: true,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.calendar_today, size: 20),
            filled: true,
            fillColor: AppColors.greyColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              dateController.text = DateFormat('MM/dd/yy').format(date);
              context.read<ExpenseBloc>().add(UpdateDate(date));
            }
          },
        ),
      ],
    );
  }
}
