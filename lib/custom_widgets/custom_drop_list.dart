import '../utils/index.dart';

class CustomDropdownInput<T> extends StatelessWidget {
  final dynamic value;
  final List<DropdownMenuItem<T>>? items;
  final void Function(dynamic)? onChanged;
  final String? Function(Object?)? validator;
  final String hintText;
  final Widget? endIcon;
  final String? labelText;
  final double borderRadius;

  const CustomDropdownInput({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    required this.hintText,
    this.endIcon,
    this.labelText,
    this.borderRadius = 8,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<T>(
            validator:
                validator ??
                (val) {
                  return null;
                },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // dropdownColor: seColor(context),
            hint: CustomText(title: hintText, is400W12S: true),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor,
              fontSize: 13,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.greyColor,
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.greyColor),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.greyColor),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.greyColor),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.greyColor.withValues(alpha: 0.5),
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            icon:
                endIcon ?? Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            isExpanded: true,
            value: value,
            items: items,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
