import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final String? fontFamily;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? padding;
  final bool underline;
  final bool lineThrough;
  final bool isWhite;
  final bool italic;
  final bool is400W12S;
  final TextDirection? textDirection;
  final GestureTapCallback? onTap;

  const CustomText({
    super.key,
    required this.title,
    this.fontSize = 14,
    this.textOverflow,
    this.is400W12S = false,
    this.maxLines,
    this.fontWeight = FontWeight.w500,
    this.color,
    this.isWhite = false,
    this.fontFamily,
    this.padding,
    this.textAlign,
    this.underline = false,
    this.lineThrough = false,
    this.italic = false,
    this.textDirection,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: underline
              ? Border(
                  bottom: BorderSide(width: 1.2, color: color ?? Colors.black),
                )
              : null,
        ),
        padding: padding ?? const EdgeInsets.all(0),
        child: Text(
          title,
          textAlign: textAlign ?? TextAlign.start,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: is400W12S ? 12 : fontSize,
            fontWeight: is400W12S ? FontWeight.w400 : fontWeight,
            fontFamily: fontFamily,
            fontStyle: italic ? FontStyle.italic : FontStyle.normal,
            color: isWhite ? Colors.white : color ?? Colors.black,
            decoration: lineThrough
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
          textDirection: textDirection,
          overflow: textOverflow,
        ),
      ),
    );
  }
}
