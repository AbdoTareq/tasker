import 'package:flutter/material.dart';
import 'package:tasker/core/app_colors.dart';

class RoundedBorder extends StatelessWidget {
  const RoundedBorder({
    super.key,
    required this.child,
    this.borderColor = kPrimaryColor,
    this.radius = 12,
    this.padding,
    this.margin,
    this.color,
  });
  final Widget child;
  final Color borderColor;
  final Color? color;
  final num radius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: ShapeDecoration(
        color: color ?? Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor),
          borderRadius: BorderRadius.all(Radius.circular(radius.toDouble())),
        ),
      ),
      child: child,
    );
  }
}
