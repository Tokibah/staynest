import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CusButton extends StatelessWidget {
  const CusButton({super.key, required this.title, required this.onPressed});

  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.sp,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,

        child: Text(
          title,
          style: TextStyle(fontSize: 23),
        ),
      ),
    );
  }
}
