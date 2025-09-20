import '../utils/index.dart';

class CustomFieldInput extends StatelessWidget {
  final double? width;
  final double? doublePaddingSuffixAll;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final Widget? iconPrefix;
  final void Function(String)? onChanged;
  final bool isPrefix;
  final bool obscureText;
  final GestureTapCallback? callback;
  final Widget? iconSuffix;
  final TextEditingController? controller;
  final bool isEnabled;
  final double padding;
  final double? heightHint;
  final double borderRadius;
  final int? maxLines;
  final GestureTapCallback? onTap;
  final bool readOnly;
  final bool showErrorBorder;
  final bool showLabel;

  // ignore: use_key_in_widget_constructors
  const CustomFieldInput({
    this.validator,
    this.doublePaddingSuffixAll,
    this.hintText,
    this.isPrefix = false,
    this.iconPrefix,
    this.onChanged,
    this.labelText,
    this.keyboardType,
    this.width,
    this.obscureText = false,
    this.showErrorBorder = true,
    this.callback,
    this.iconSuffix,
    this.initialValue,
    this.controller,
    this.isEnabled = true,
    this.padding = 8,
    this.heightHint,
    this.borderRadius = 8,
    this.maxLines = 1,
    this.onTap,
    this.readOnly = false,
    this.showLabel = false,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Height(10),
          CustomText(title: labelText ?? ""),
          Height(10),
        ],
        GestureDetector(
          onTap: onTap,
          child: TextFormField(
            initialValue: initialValue,
            maxLines: maxLines,
            enabled: isEnabled,
            validator: validator,
            readOnly: readOnly,
            controller: controller,
            obscureText: obscureText,
            onChanged: onChanged,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor,
            ),
            decoration: InputDecoration(
              // contentPadding: EdgeInsets.symmetric(horizontal: 10),
              suffixIcon: Padding(
                padding: EdgeInsets.all(doublePaddingSuffixAll ?? 8.0),
                child: iconSuffix,
              ),
              prefixIcon: !isPrefix
                  ? null
                  : Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: iconPrefix,
                    ),
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 12,
                color: AppColors.hintColor,
                fontWeight: FontWeight.w400,
                height: heightHint,
              ),
              filled: true,
              fillColor: AppColors.greyColor,
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
                borderSide: BorderSide(
                  color: showErrorBorder ? Colors.red : AppColors.greyColor,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
