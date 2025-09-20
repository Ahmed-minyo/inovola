import '../../../../utils/index.dart';
import 'custom_head_title.dart';

class DateSection extends StatelessWidget {
  const DateSection({super.key, required this.dateController, this.onTap});

  final TextEditingController dateController;
  final void Function()? onTap;

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
          onTap: onTap,
        ),
      ],
    );
  }
}
