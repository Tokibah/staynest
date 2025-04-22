import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:staynest_1/core/theme.dart';
import 'package:staynest_1/firebase_options.dart';
import 'features/authentication/presentation/welcome_page.dart';
import 'features/frame/presentation/frame_page.dart';

//35, 23

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then(
        (value) => runApp(ChangeNotifierProvider(
        create: (context) => ThemeProvider(), child: const StayNest())),
  );
}

class StayNest extends StatelessWidget {
  const StayNest({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return GlobalLoaderOverlay(
      overlayWidgetBuilder: (progress) {
        return const Center(
          child: SpinKitChasingDots(color: Colors.black, size: 50),
        );
      },
      overlayColor: Colors.grey,
      child: ScreenUtilInit(
        designSize: const Size(412, 915),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Provider.of<ThemeProvider>(context).themeData,
            home: child,
          );
        },
        child: user == null ? const WelcomePage() : const FrameLayer(),
      ),
    );
  }
}
