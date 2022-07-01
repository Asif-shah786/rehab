import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    required this.child,
    required this.color,
    this.borderRadius: 2,
    required this.onPressed, this.fSize : false,
  }) : assert(borderRadius != null);
  final Widget child;
  final Color? color;
  final double borderRadius;
  final VoidCallback? onPressed;
  final bool fSize;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
        // side: const BorderSide(width:3, color:Colors.red), //border width and color
        onPrimary: Colors.white,
        primary: color,
        minimumSize: fSize? Size.fromHeight(50) : Size(60, 30),
        padding: EdgeInsets.symmetric(horizontal: 16,),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
      ),
      onPressed: onPressed,
      child: child,);
  }
}
