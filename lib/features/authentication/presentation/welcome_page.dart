import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:staynest_1/features/authentication/presentation/log_in_page.dart';
import 'package:staynest_1/features/authentication/presentation/sign_up_page.dart';
import 'package:staynest_1/features/authentication/widget/auth_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void initState() {
    context.loaderOverlay.hide();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.sp, vertical: 90.h),
        child: Column(children: [
          Container(
            height: 460.sp,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.cover)),
          ),

          CusButton(
            title: "Get Started",
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUpPage())),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => LogInPage())),
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Text(
              "Already a member?",
              style: TextStyle(fontSize: 16),
                                ),
                                TextButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LogInPage())),
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )),
                              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
