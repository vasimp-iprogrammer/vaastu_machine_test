import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vastu_machine_test/base/base_page.dart';
import 'package:vastu_machine_test/enums/connectivity_status.dart';
import 'package:vastu_machine_test/home/home_page.dart';
import 'package:vastu_machine_test/interfaces/common_interface.dart';
import 'package:vastu_machine_test/server/api_auth_repository.dart';
import 'package:vastu_machine_test/utility/preferences.dart';
import 'package:vastu_machine_test/utility/utils.dart';
import 'package:vastu_machine_test/vaastu_score/model/calculate_vaastu_score_model.dart';
import 'package:vastu_machine_test/vaastu_score/view/room_details_screen.dart';
import 'package:vastu_machine_test/widget/custom_button.dart';
import 'package:vastu_machine_test/widget/custom_image.dart';
import 'package:vastu_machine_test/widget/custom_progress_dialog.dart';
import 'package:vastu_machine_test/widget/custom_textfield.dart';

class CalculateScoreScreen extends BasePage {
  late Map<String, dynamic> selectedRoomMap;
  @override
  _CalculateScoreScreen createState() => _CalculateScoreScreen();

  CalculateScoreScreen({required this.selectedRoomMap});
}

class _CalculateScoreScreen extends BaseState<CalculateScoreScreen>
    with BasicPage
    implements CommonInterface {
  Map<String, dynamic> selectedRoomMap = {};
  var vaastuScore = "";
  var vaastuScoreStatus = "";
  late List<RoomWiseVastuScore> roomWiseVastuScore = [];
  late CustomProgressDialog _customProgressDialog;

  @override
  Widget appBarLeftIcon() {
    return CustomImage(
      size: 12,
      assetPath: ASSETUTILS.ASSETS_ARROW_LEFT,
      commonInterface: this,
      type: SourceType.BACK.toString(),
    );
  }

  @override
  Widget appBarRightIcon() {
    return CustomImage(
      size: 12,
      assetPath: ASSETUTILS.ASSETS_COMPASS_TAG,
      commonInterface: this,
      type: '',
    );
  }

  @override
  Color backgroundColor() {
    return ColorUtils.color_app_bg;
  }

  @override
  Widget body() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: ColorUtils.color_white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "OVER ALL VAASTU SCORE",
                    style: TextStyle(
                        color: ColorUtils.color_labels,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1.0),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          isVisible: true,
                          text: vaastuScore,
                          colors: ColorUtils.color_pink_red,
                          fontWeight: FontWeight.bold,
                          size: 28,
                          isBold: true,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                           // print('call show');
                            customDialogBox(context);
                          },
                          child: CustomTextField(
                            isVisible: true,
                            text: vaastuScoreStatus,
                            colors: ColorUtils.color_vaastu_score_label,
                            fontWeight: FontWeight.bold,
                            size: 12,
                            isBold: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: ColorUtils.color_black,
                    height: 2,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "ROOM-WISE BREAKUP OF VAASTU SCORE",
                    style: TextStyle(
                        color: ColorUtils.color_labels,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1.0),
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    isVisible: true,
                    text:
                        "Tap on any room name to know more about the details of the room.",
                    colors: ColorUtils.color_labels,
                    fontWeight: FontWeight.w400,
                    size: 12,
                    isBold: false,
                  ),
                  selecteRoomListWidget(),
                ],
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
                text: "RESET VAASTU SCORE",
                isValidated: true,
                isImageRequired: false,
                commonInterface: this,
                typeOfClick: SourceType.RESET_SCORE.toString(),
                buttonColor: ColorUtils.color_red,
                textColor: ColorUtils.color_white,
                assets: ''),
            SizedBox(height: 20),
            Image(
              image: AssetImage(ASSETUTILS.ASSETS_SCORE_BOTTOM),
            )
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
  void getText(String str, String type) {
    // TODO: implement getText
  }

  @override
  initializingObjects() {
    selectedRoomMap = widget.selectedRoomMap;

  Constants.check().then((intenet) {
      if (intenet != null && intenet) {
         Future.delayed(Duration.zero, () {
           getScore();
         });
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Check internet conection.."),
    ));
    print("No internet");
      }
      // No-Internet Case
    });


  }

  @override
  isAppBarVisible() {
    return true;
  }

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
    Navigator.of(context).pop();
  }

  @override
  void onClick(String type) {
    if (type == SourceType.RESET_SCORE.toString()) {
      restVaastuScore();
    } else {
      if (type == SourceType.BACK.toString()) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void onItemSelected(String type, model) {
    // TODO: implement onItemSelected
  }

  @override
  String pageTitle() {
    return APPTITLES.VAASTU_SCORE;
  }

  void getScore() async {
    _customProgressDialog = CustomProgressDialog(context: context);
    await _customProgressDialog.showProgressDialog();
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    try {
      var resBody = {};
      selectedRoomMap.forEach((key, value) {
        resBody[key.replaceAll('-', " ")] = value;
      });
      var selectedRoom = {};
      selectedRoom["selectedRoomsAndDirection"] = resBody;
      String str = encoder.convert(selectedRoom);
      print(str);
      getResponse(selectedRoom).then((value) {
        setState(() {
          _customProgressDialog.hideProgressDialog();
          CalculateVaastuScoreModel calculateVaastuScore = value;
          vaastuScore = calculateVaastuScore.payload.data.overallVastuScore;
          vaastuScoreStatus =
              calculateVaastuScore.payload.data.vastuScoreStatus;
          roomWiseVastuScore =
              calculateVaastuScore.payload.data.roomWiseVastuScore;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future<CalculateVaastuScoreModel> getResponse(var selectedRoom) {
    return ApiAuthRepository(context).getCalculateVaastuScore(selectedRoom);
  }

  Widget selecteRoomListWidget() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: roomWiseVastuScore.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RoomDetailsScreen(
                          title: roomWiseVastuScore[index].room)));
                },
                trailing: Container(
                  width: 120,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: roomWiseVastuScore[index]
                                  .legend
                                  .toUpperCase()
                                  .trim()
                                  .toUpperCase() ==
                              'Favorable'.toUpperCase()
                          ? ColorUtils.color_favourate_bg
                          : roomWiseVastuScore[index].legend.toUpperCase() ==
                                  "NEUTRAL"
                              ? ColorUtils.color_netural_bg
                              : roomWiseVastuScore[index]
                                          .legend
                                          .toUpperCase() ==
                                      "UNFAVOURABLE"
                                  ? ColorUtils.color_unfavourate_bg
                                  : ColorUtils.color_white),
                  child: Center(
                    child: Text(
                      roomWiseVastuScore[index].legend.toUpperCase(),
                      style: TextStyle(
                          color: ((roomWiseVastuScore[index]
                                      .legend
                                      .trim()
                                      .toString()
                                      .toUpperCase() ==
                                  'Favorable'.toString().toUpperCase())
                              ? ColorUtils.color_favourate
                              : roomWiseVastuScore[index]
                                          .legend
                                          .trim()
                                          .toString()
                                          .toUpperCase() ==
                                      'NEUTRAL'
                                  ? ColorUtils.color_netural
                                  : roomWiseVastuScore[index]
                                              .legend
                                              .trim()
                                              .toString()
                                              .toUpperCase() ==
                                          'UNFAVOURABLE'
                                      ? ColorUtils.color_pink_red
                                      : ColorUtils.color_red),
                       fontSize: 14,
                          
                          fontFamily: FontFamily.NOTOSANS_BOLD),
                    ),
                  ),
                ),
                title: Text(roomWiseVastuScore[index].room,
                style: TextStyle(fontSize: 14,
                fontFamily: FontFamily.NOTOSANS_BOLD,
                color: ColorUtils.color_labels),),
                subtitle: Text(
                  "( ${roomWiseVastuScore[index].direction} )",
                  style: TextStyle(
                    fontFamily: FontFamily.NOTOSANS_REGULAR,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
                  ),
              ),
              Divider(color: ColorUtils.color_black)
            ],
          );
        });
  }

  void restVaastuScore() async {
    Map<String, dynamic> selectedRoomMap = {};
    await Prefs.setString("selectedRoomMap", json.encode(selectedRoomMap));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomePageScreen()));
  }

  customDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                isVisible: true,
                                text: "Legend",
                                colors: ColorUtils.color_black,
                                fontWeight: FontWeight.bold,
                                size: 14,
                                isBold: true,
                              ),
                              SizedBox(height: 20),
                              CustomTextField(
                                isVisible: true,
                                text:
                                    "Here is what diffent Compliant score mens!",
                                colors: ColorUtils.color_labels,
                                fontWeight: FontWeight.w400,
                                size: 14,
                                isBold: false,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Excellemt".toUpperCase(),
                                style: TextStyle(
                                    color: ColorUtils.color_vaastu_score_label,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    letterSpacing: 1.0),
                              ),
                              SizedBox(height: 10),
                              CustomTextField(
                                isVisible: true,
                                text:
                                    "Your plan as per hight stander of vaastu.Good Job!",
                                colors: ColorUtils.color_labels,
                                fontWeight: FontWeight.w400,
                                size: 14,
                                isBold: false,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Good".toUpperCase(),
                                style: TextStyle(
                                    color: ColorUtils.color_vaastu_score_label,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    letterSpacing: 1.0),
                              ),
                              SizedBox(height: 10),
                              CustomTextField(
                                isVisible: true,
                                text:
                                    "Most of the room in your layout have porper vaastu compilance",
                                colors: ColorUtils.color_labels,
                                fontWeight: FontWeight.w400,
                                size: 14,
                                isBold: false,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Improvment required".toUpperCase(),
                                style: TextStyle(
                                    color: ColorUtils.color_vaastu_score_label,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    letterSpacing: 1.0),
                              ),
                              SizedBox(height: 10),
                              CustomTextField(
                                isVisible: true,
                                text:
                                    "If you are in planning stage, try repositionig some rooms to improve vaastu compilance",
                                colors: ColorUtils.color_labels,
                                fontWeight: FontWeight.w400,
                                size: 14,
                                isBold: false,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Non-vaastu compliant".toUpperCase(),
                                style: TextStyle(
                                    color: ColorUtils.color_vaastu_score_label,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    letterSpacing: 1.0),
                              ),
                              SizedBox(height: 10),
                              CustomTextField(
                                isVisible: true,
                                text:
                                    "Please consult a vaastu expert to help design the layout accroding to vaastu ",
                                colors: ColorUtils.color_labels,
                                fontWeight: FontWeight.w400,
                                size: 14,
                                isBold: false,
                              ),
                              SizedBox(height: 30)
                            ],
                          ),
                        ) //
                        ,
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: 
                    // FloatingActionButton(
                    //   child: ImageIcon(
                    //     AssetImage(ASSETUTILS.ASSETS_CLOSE),
                    //     color: Color(0xFF3A5A98),
                    //   ),
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //   },
                    //   // shape: RoundedRectangleBorder(
                    //   //     borderRadius: BorderRadius.circular(80)),
                    //    backgroundColor: Colors.white,
                    //   // mini: true,
                    //   // elevation: 5.0,
                    // ),
                    IconButton(onPressed: (){
                       Navigator.pop(context);
                    },
                     icon: Image.asset(ASSETUTILS.ASSETS_CLOSE))
                  ),
                ],
              ));
        });
  }
}
