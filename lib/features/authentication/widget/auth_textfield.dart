import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CusTextField extends StatefulWidget {
  const CusTextField(
      {super.key,
      required this.hint,
      required this.controller,
      required this.isObscure});

  final String hint;
  final TextEditingController controller;
  final bool isObscure;

  @override
  State<CusTextField> createState() => _CusTextFieldState();
}

class _CusTextFieldState extends State<CusTextField> {
  bool show = false;

  @override
  void initState() {
    show = widget.isObscure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.hint,
              style: TextStyle(fontFamily: "NType", fontSize: 18.sp),
            ),
            TextFormField(
              controller: widget.controller,
              decoration: InputDecoration(
                suffixIcon: widget.isObscure
                    ? IconButton(
                        onPressed: () => setState(() => show = !show),
                        icon: show
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off))
                    : null,
              ),
              validator: (value) => value == null || value.isEmpty ? "" : null,
              obscuringCharacter: '*',
              obscureText: show,
            ),
          ]),
    );
  }
}
