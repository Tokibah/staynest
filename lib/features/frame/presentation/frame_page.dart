import 'package:flutter/material.dart';
import '../../explore/presentation/explore_page.dart';
import '../../home/presentation/home_page.dart';
import '../../message/presentation/message_page.dart';
import '../../profile/presentation/profile_page.dart';
import '../widget/bot_navi_bar.dart';

class FrameLayer extends StatefulWidget {
  const FrameLayer({super.key});

  @override
  State<FrameLayer> createState() => _FrameLayerState();
}

class _FrameLayerState extends State<FrameLayer> {

  final List<Widget> _page = [HomePage(), ExplorePage(), MessagePage(), ProfilePage()];
  final _currIndex = ValueNotifier<int>(0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Stack(children: [
            ValueListenableBuilder(
                valueListenable: _currIndex,
                builder: (context, currPage, child) {
                  return IndexedStack(
                    index: _currIndex.value,
                    children: _page,
                  );
                }
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: BottomBar(
                  currIndex: _currIndex,
                ),
              ),
            )
          ]),
        ));
  }
}

/*
    Player? player;
    final user = FirebaseAuth.instance.currentUser;


    Future<void> emailVerifyNofi() async {
    await user?.reload();
    if (user != null && !user!.emailVerified) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Icon(Icons.email, size: 50),
                    ),
                  ),
                  const Text(
                    "Pautan pengaktifan emel telah dihantar ke emel anda\njika sudah sila reset aplikasi",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Teruskan",
                      style: TextStyle(color: Colors.grey),
                    )),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await FirebaseAuth.instance.currentUser
                            ?.sendEmailVerification();
                      },
                      child: const Text(
                        "Minta pautan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                )
              ],
            );
          });
    }
  }

  void listenToAuthChanges() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    });
  }

  void getData() async {
    player = await Player.getPlayer();
    setState(() {});
  }

  @override
  void initState() {
    listenToAuthChanges();
    getData();

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      emailVerifyNofi();
    });
  } */
