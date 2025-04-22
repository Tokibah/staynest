import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staynest_1/features/authentication/data/auth_service.dart';
import 'package:staynest_1/features/authentication/widget/auth_button.dart';
import 'package:staynest_1/features/authentication/widget/auth_textfield.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _emailController = TextEditingController(text: "");
  final _passwordController = TextEditingController(text: "");

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.only(left: 20.h),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30)),
              child: Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18.sp),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Log In",
                style: TextStyle(
                  fontFamily: "NType",
                  fontSize: 35.sp,
                )),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.sp),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  CusTextField(
                      hint: "Email",
                      controller: _emailController,
                      isObscure: false),
                  CusTextField(
                      hint: "Password",
                      controller: _passwordController,
                      isObscure: true),
                ]),
              ),
            ),
            CusButton(
                title: "Log in",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    AuthService.login(
                        context, _emailController.text, _passwordController.text);
                  }
                }),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () {}, child: Text("I forgot my password", style: TextStyle(color: Colors.grey),)),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
