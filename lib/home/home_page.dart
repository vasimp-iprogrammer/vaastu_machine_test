import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vastu_machine_test/base/base_page.dart';
import 'package:vastu_machine_test/compass_tool/compass_tool.dart';
import 'package:vastu_machine_test/enums/connectivity_status.dart';
import 'package:vastu_machine_test/interfaces/common_interface.dart';
import 'package:vastu_machine_test/utility/utils.dart';
import 'package:vastu_machine_test/vaastu_score/view/vaastu_score_check.dart';
import 'package:vastu_machine_test/widget/custom_image.dart';
import 'package:vastu_machine_test/widget/custom_textfield.dart'; 
import 'package:video_player/video_player.dart';

class HomePageScreen extends BasePage {
  @override
  _HomePageScreen createState() => _HomePageScreen();
}

class _HomePageScreen extends BaseState<HomePageScreen>
    with BasicPage
    implements CommonInterface {
  int _current = 0;
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  // final List<String> images = [
  //   'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
  //   'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
  //   'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  //   'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
  //   'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
  //   'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  //   'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  // ];
  @override
  Widget appBarLeftIcon() {
    return Container();
  }

  @override
  Widget appBarRightIcon() {
    return Container();
  }

  @override
  Color backgroundColor() => ColorUtils.color_app_bg;

  @override
  Widget body() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
              child: new CustomTextField(
                isVisible: true,
                text: "Pick the ideal tool for you:",
                colors: ColorUtils.color_labels,
                fontWeight: FontWeight.bold,
                size: 14,
                isBold: true,
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CompassToolScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: ColorUtils.color_white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Stack(
                          children: [
                            ClipRRect(
                              child: Image.asset(ASSETUTILS.ASSETS_COMPASS_TOOl,
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(64, 25, 25, 25),
                              child: Image.asset(
                                  ASSETUTILS.ASSETS_COMPASS_SMALL,
                                  fit: BoxFit.cover),
                            ),
                          ],
                        )),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                isVisible: true,
                                text: "Compass Tool",
                                colors: ColorUtils.color_room_list_labels,
                                fontWeight: FontWeight.bold,
                                size: 14,
                                isBold: true,
                              ),
                              SizedBox(height: 5),
                              CustomTextField(
                                isVisible: true,
                                text: "Output Time: 1 min",
                                colors: ColorUtils.color_labels_light,
                                fontWeight: FontWeight.w400,
                                size: 11,
                                isBold: false,
                              ),
                              SizedBox(height: 05),
                              CustomTextField(
                                isVisible: true,
                                text:
                                    "Point in the direction of specific room to know their suitability according to vaastu guidelines",
                                colors: ColorUtils.color_labels,
                                fontWeight: FontWeight.w400,
                                size: 12,
                                isBold: false,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VaastuScoreCheckScreen(),
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: ColorUtils.color_white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Stack(children: [
                        ClipRRect(
                          child: Image.asset(ASSETUTILS.ASSETS_VAASTU_SCRORE,
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ])),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              isVisible: true,
                              text: "Vaastu Score Check",
                              colors: ColorUtils.color_room_list_labels,
                              fontWeight: FontWeight.bold,
                              size: 14,
                              isBold: true,
                            ),
                            SizedBox(height: 5),
                            CustomTextField(
                                isVisible: true,
                                text: "Output Time: 1 min",
                                colors: ColorUtils.color_labels_light,
                                fontWeight: FontWeight.w400,
                                size: 11,
                                isBold: false,
                              ),
                            SizedBox(height: 05),
                            CustomTextField(
                              isVisible: true,
                              text:
                                  "Input the location of all the rooms in your home and get a vaastu score instantly",
                              colors: ColorUtils.color_labels,
                              fontWeight: FontWeight.w400,
                              size: 12,
                              isBold: false,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "VIDEOS",
                    style: TextStyle(
                        color: ColorUtils.color_labels,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 1.0),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "VIEW ALL",
                      style: TextStyle(
                          color: ColorUtils.color_red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          letterSpacing: 1.0),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child:SizedBox(
                height: 240,
                child: PageView.builder(
                  controller: controller,
                  
                  // itemCount: pages.length,
                  itemBuilder: (_, index) {
                   // return pages[index % pages.length];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                    ),
                    child: Center(
                          child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8)),
                              //     child: Image.network(images[index],
                              //   fit: BoxFit.fill,
                              //  ),
                               child: Image.asset(ASSETUTILS.ASSETS_PICK,
                                 width: 300,
                                 fit: BoxFit.cover),
                            ),
                          ),
                          //               Flexible(
                          //                                           child: AspectRatio(
                          //   aspectRatio: _controller.value.aspectRatio,
                          //   // Use the VideoPlayer widget to display the video.
                          //   child: VideoPlayer(_controller),
                          // ),
                          //               ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: Text(
                              "Ten things you should konw before puchansing a plot",
                              style: TextStyle(
                                  color: ColorUtils.color_room_list_labels,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  CustomImage(
                                    size: 8,
                                    assetPath: ASSETUTILS.ASSETS_ARROW_LIKE,
                                    commonInterface: this,
                                    type: SourceType.BACK.toString(),
                                  ),
                                  Text(
                                    "10 likes",
                                    style:
                                        TextStyle(color: ColorUtils.color_red),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  CustomImage(
                                    size: 8,
                                    assetPath: ASSETUTILS.ASSETS_ARROW_VIEW,
                                    commonInterface: this,
                                    type: SourceType.BACK.toString(),
                                  ),
                                  Text(
                                    "10 views",
                                    style:
                                        TextStyle(color: ColorUtils.color_red),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                        ],
                    )),
                  ),
                      );
                  },
                ),
              ),
            ),
           Center(
             child: SmoothPageIndicator(
                  controller: controller,
                  count: 6,
                  effect: WormEffect(
                    dotHeight: 5,
                    dotWidth: 5,
                    dotColor: ColorUtils.color_light_grey,
                    activeDotColor: ColorUtils.color_red,
                    type: WormType.normal,
                    // strokeWidth: 5,
                  ),
                ),
           ),
          ],
        ),
      ),
    );
  }

  @override
  Widget getBottomWidget() {
    return Container();
  }

  @override
  initializingObjects() {
    print("home page");
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  isAppBarVisible() => true;

  @override
  bool isBottomNavigationIsible() {
    return false;
  }

  @override
  isNaviagtionDrawerVisible() {
    return false;
  }

  @override
  onBackPressed(context) {
    SystemNavigator.pop();
  }

  @override
  String pageTitle() {
    return APPTITLES.HOME_PAGE;
  }

  @override
  void getText(String str, String type) {
    // TODO: implement getText
  }

  @override
  void onClick(String type) {
    // TODO: implement onClick
  }

  @override
  void onItemSelected(String type, model) {
    // TODO: implement onItemSelected
  }
}
