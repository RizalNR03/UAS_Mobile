import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'mytext.dart';

class FillButton extends StatelessWidget {
  const FillButton(
      {super.key,
      this.width,
      required this.onClick,
      required this.label,
      this.background});
  final double? width;
  final Function() onClick;
  final String label;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
          onPressed: onClick,
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(2.h),
              backgroundColor: background ?? Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.h))),
          child: MyText(
            label,
            weight: FontWeight.w600,
            color: Colors.white,
            maxLines: 2,
          )),
    );
  }
}