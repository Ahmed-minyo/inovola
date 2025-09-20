import '../../utils/index.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isSecondary;
  final IconData? icon;
  final Widget? iconWidget;
  final bool visibleIcon;
  final bool isActive;
  final Color colorButton;
  final Color colorText;
  final Color iconColor;
  final double borderRadius;
  final double fontSizeText;
  final double? widthH;
  final double? height;
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry? margin;

  const CustomButton({
    super.key,
    required this.text,
    this.isSecondary = false,
    this.visibleIcon = false,
    this.isActive = true,
    this.icon,
    this.iconWidget,
    this.margin,
    this.widthH,
    this.height,
    this.colorButton = AppColors.blueColor,
    this.iconColor = AppColors.blueColor,
    this.colorText = Colors.white,
    this.borderRadius = 11.0,
    this.fontSizeText = 14,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Container(
        margin: margin,
        width: widthH ?? width(context),
        height: height ?? 45,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: isSecondary
              ? Border.all(color: colorButton, width: 1.5)
              : null,
          color: isSecondary
              ? null
              : isActive
              ? colorButton
              : colorButton.withValues(alpha: 0.3),
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: isSecondary ? colorButton : colorText,
                  fontSize: fontSizeText,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Visibility(
                visible: visibleIcon,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: iconWidget ?? Icon(icon, color: iconColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
