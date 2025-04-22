import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:staynest_1/features/authentication/presentation/welcome_page.dart';
import '../../../core/user_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    EndUser user = EndUser(name: "Username", email: "emailTest@gmail.com", image: "");

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
          shadowColor: Colors.transparent,
          title: Text("Profile",
              style: TextStyle(
                fontFamily: "NType",
                fontSize: 35.sp,
              ))),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: 20.w, right: 20.w, top: 15.sp, bottom: 90.sp),
          child: Center(
            child: Column(children: [
              CircleAvatar(
                radius: 40.sp,
                backgroundImage: AssetImage(
                  user.image != ""
                      ? user.image[0]
                      : "assets/images/profileholder.jpg",
                ),
              ),
              Text(
                user.name,
                style: TextStyle(fontSize: 20.sp),
              ),
              Text(user.email,
                  style: TextStyle(fontSize: 20.sp, color: Colors.grey)),
              ElevatedButton(onPressed: () async  {
                await FirebaseAuth.instance.signOut();
                if(context.mounted) {
                  context.loaderOverlay.show();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage()));
                }
              }, child: Text("Log out")),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Settings", style: TextStyle(fontSize: 25.sp))),
              Column(
                  children: List.generate(10, (index) {
                    return Container(
                      height: 55,
                      margin: const EdgeInsets.all(5),
                      padding: EdgeInsets.only(left: 20.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Test ${index + 1}",
                          style: TextStyle(fontSize: 19.sp),
                        ),
                      ),
                    );
                  })),
            ]),
          ),
        ),
      ),
    );
  }
}
