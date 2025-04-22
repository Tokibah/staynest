import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:loader_overlay/loader_overlay.dart';
import '../../../core/roof_service.dart';
import '../../../core/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _section = ["For You", "Highlights", "Sponsored"];
  int _selectedIndex = 0;

  final _pageController = PageController();
  final List<Roof> roofList = [
    Roof(name: "Test 1", location: "Location1", rating: 3, feature: [
      "Feature 1",
    ], image: []),
    Roof(
        name: "Test 2",
        location: "Location 2",
        rating: 4,
        feature: ["Feature 1", "Feature 2"],
        image: []),
    Roof(
        name: "Test 3",
        location: "Location 3",
        rating: 5,
        feature: ["Feature 1", "Feature 2", "Feature 3", "Feature 4"],
        image: [])
  ];

  @override
  void initState() {
    context.loaderOverlay.hide();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
          shadowColor: Colors.transparent,
          title: Text("Home",
              style: TextStyle(
                fontFamily: "NType",
                fontSize: 35.sp,
              ))),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(top: 10.sp),
            child: SizedBox(
              height: 48.sp,
              child: ListView.builder(
                  itemCount: _section.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    bool isSelect = _selectedIndex == index;
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: ChoiceChip(
                        label: Text(
                          _section[index],
                          style: TextStyle(
                              color: isSelect
                                  ? ThemeProvider.lightBack
                                  : ThemeProvider.darkBack,
                              fontFamily: "NType",
                              fontSize: 15.5.sp),
                        ),
                        showCheckmark: false,
                        selected: isSelect,
                        selectedColor: Colors.black,
                        onSelected: (value) => setState(() {
                          _selectedIndex = index;
                        }),
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            side:
                            const BorderSide(width: 0, color: Colors.white),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Container(
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(30)),
              height: 480.sp,
              child: PageView.builder(
                controller: _pageController,
                itemCount: roofList.length,
                itemBuilder: (context, index) {
                  Roof roof = roofList[index];

                  return Container(
                    margin: EdgeInsets.only(top: 10.sp, bottom: 20.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(roof.image.isNotEmpty
                                ? (roof.image[0] != ""
                                ? roof.image[0]!
                                : "assets/images/imageHolder.jpg")
                                : "assets/images/imageHolder.jpg"))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Expanded(
                              child: SizedBox(
                                height: 55.sp,
                                child: ListView.builder(
                                    itemCount: roof.feature.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                          padding: EdgeInsets.only(
                                              top: 8.sp, left: 10.h),
                                          child: Chip(
                                            label: Text(
                                              roof.feature[index],
                                              style: TextStyle(
                                                  color:
                                                  ThemeProvider.lightBack,
                                                  fontSize: 12.sp),
                                            ),
                                            backgroundColor:
                                            ThemeProvider.darkBack,
                                            shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    width: 0,
                                                    color:
                                                    ThemeProvider.darkBack),
                                                borderRadius:
                                                BorderRadius.circular(30)),
                                          ));
                                    }),
                              ),
                            ),
                          ]),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.all(15.sp),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(roof.name,
                                      style: TextStyle(
                                          fontFamily: '', fontSize: 25.sp)),
                                  Text(roof.location,
                                      style: TextStyle(
                                          fontFamily: '',
                                          fontSize: 20.sp,
                                          color: Colors.grey)),
                                  PannableRatingBar(
                                      rate: roof.rating,
                                      items: List.generate(5, (index) {
                                        return RatingWidget(
                                            selectedColor: Colors.amber,
                                            unSelectedColor: Colors.grey,
                                            child:
                                            Icon(Icons.star, size: 30.sp));
                                      }))
                                ]),
                          ),
                        ]),
                  );
                },
                scrollDirection: Axis.vertical,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
