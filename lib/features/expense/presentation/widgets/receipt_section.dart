import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/index.dart';
import '../bloc/event/expense_event.dart';
import '../bloc/expense_bloc.dart';
import 'custom_head_title.dart';

class ReceiptSection extends StatelessWidget {
  const ReceiptSection({super.key, this.receiptPath});
  final String? receiptPath;

  @override
  Widget build(BuildContext context) {
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
            child: receiptPath != null
                ? Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(receiptPath!),
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
                        onPressed: () =>
                            context.read<ExpenseBloc>().add(ResetExpense()),
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
}
