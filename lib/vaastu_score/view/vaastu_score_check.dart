import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vastu_machine_test/base/base_page.dart';
import 'package:vastu_machine_test/enums/connectivity_status.dart';
import 'package:vastu_machine_test/interfaces/common_interface.dart';
import 'package:vastu_machine_test/server/api_auth_repository.dart';
import 'package:vastu_machine_test/utility/preferences.dart';
import 'package:vastu_machine_test/utility/utils.dart';
import 'package:vastu_machine_test/vaastu_score/view/calculate_score.dart';
import 'package:vastu_machine_test/vaastu_score/model/roomlist_response_model.dart';
import 'package:vastu_machine_test/vaastu_score/view/select_room.dart';
import 'package:vastu_machine_test/widget/custom_image.dart';
import 'package:vastu_machine_test/widget/custom_textfield.dart';

class VaastuScoreCheckScreen extends BasePage {
  @override
  _VaastuScoreCheckScreen createState() => _VaastuScoreCheckScreen();
}

class _VaastuScoreCheckScreen extends BaseState<VaastuScoreCheckScreen>
    with BasicPage
    implements CommonInterface {
  List<dynamic> roomPositionList = [
    "North-West",
    "North",
    "North-East",
    "West",
    "Centre",
    "East",
    "South-West",
    "South",
    "South-East"
  ];
  List<String> demo = ["hello", "world", "vasim", "vasim", "vasim", "vasim"];
  late int checkedIndex = -1;
  late String mapdata;
  //late Map<String,List<dynamic>> selectedRoomMap;
  late Map<String, dynamic> selectedRoomMap = {};
  List<dynamic> temp = [];
  late int tempIndex;
  late SharedPreferences sharedPreferences;
  bool mapFlag = false;

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
    return ColorUtils.color_white;
  }

  @override
  Widget body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ROOM SELECTOR",
              style: TextStyle(
                  color: ColorUtils.color_labels,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.NOTOSANS_BOLD,
                  fontSize: 14,
                  letterSpacing: 1.0),
            ),
            SizedBox(height: 10),
            CustomTextField(
                isVisible: true,
                text:
                    "Select the room thar are present in each direction of your home by tapping on textboxes below:",
                isBold: false,
                size: 12,
                colors: ColorUtils.color_labels,
                fontWeight: FontWeight.w400),
            SizedBox(height: 20),
            getRoomDirection(),
          ],
        ),
      ),
    );
  }

  Widget getRoomDirection() {
    return GridView.builder(
      itemCount: roomPositionList.length,
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
      itemBuilder: (BuildContext context, int index) {
        bool checked = index == checkedIndex;
        return InkResponse(
          onTap: () {
            setState(() {
              checkedIndex = index;
            });
            print(roomPositionList[index]);

            callNextPage(index);
          },
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  children: [
                    CustomTextField(
                        isVisible: true,
                        text: roomPositionList[index].toString().toUpperCase(),
                        isBold: false,
                        size: 12,
                        colors: checked
                            ? ColorUtils.color_red
                            : ColorUtils.color_labels,
                        fontWeight: FontWeight.bold),
                    SizedBox(height: 10),
                    Center(child: getTextWidgets(selectedRoomMap, index)),
                    moreText(index)
                  ],
                ),
              )),
        );
      },
    );
  }

  @override
  Widget getBottomWidget() {
    return GestureDetector(
      onTap: () {
        if (mapFlag == true) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CalculateScoreScreen(
                    selectedRoomMap: selectedRoomMap,
                  )));
        }
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: mapFlag == true
                ? ColorUtils.color_red
                : ColorUtils.color_calcul_score,
          ),
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "CALCULATE SCORE",
                style: TextStyle(
                  color: ColorUtils.color_white, 
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.NOTOSANS_REGULAR),
              ),
            ],
          )),
    );
  }

  void callNextPage(int index) async {
    for (int i = 0; i < selectedRoomMap.length; i++) {
      if (selectedRoomMap.containsKey(roomPositionList[index])) {
        temp = selectedRoomMap[roomPositionList[index]];

        print("alredy has data $temp");
      }else{
        temp=[];
      }
    }
    List<dynamic> seletedRoom =
        await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SelectRoomScreen(
        roomDirection: roomPositionList[index],
        index: index,
        prevSelectedRoomList: temp,
      ),
    ));
  //  print("after back =$seletedRoom");

    setState(() {
      if (seletedRoom.length > 0)
        selectedRoomMap[roomPositionList[index]] = seletedRoom;
        print("map data 1 =$selectedRoomMap");
      addMap();
      checkMapSize();
    });
  }

  @override
  void getText(String str, String type) {
    // TODO: implement getText
  }

  @override
  initializingObjects() async {
    await Prefs.init();
    mapdata = Prefs.getString("selectedRoomMap");
    try {
      setState(() {
        selectedRoomMap = json.decode(mapdata);
        print("map in init $selectedRoomMap");
        checkMapSize();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  isAppBarVisible() {
    return true;
  }

  @override
  bool isBottomNavigationIsible() {
    return true;
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
    if (type == SourceType.BACK.toString()) {
      Navigator.of(context).pop();
    }
  }

  @override
  void onItemSelected(String type, model) {
    // TODO: implement onItemSelected
  }

  @override
  String pageTitle() {
    return APPTITLES.VAASTU_SCORE_CHECK;
  }

  void addMap() async {
    selectedRoomMap.removeWhere((key, value) => key == null || value == null);

    await Prefs.setString("selectedRoomMap", json.encode(selectedRoomMap));
    mapdata = Prefs.getString("selectedRoomMap");
      print(selectedRoomMap=json.decode(mapdata));
  }

  Widget getTextWidgets(Map<String, dynamic> strings, index) {
    List<Widget> list = [];
    if (selectedRoomMap.containsKey(roomPositionList[index])) {
      if (selectedRoomMap[roomPositionList[index]].length == 0) {
        return new Container(
          child: CustomTextField(
              isVisible: true,
              text: "No Room\n Selected",
              isBold: false,
              size: 12,
              colors: ColorUtils.color_labels_light,
              fontWeight: FontWeight.w400),
        );
      } else {
        if (selectedRoomMap[roomPositionList[index]].length > 2) {
          for (var i = 0; i < 2; i++) {
            list.add(new Text(
              selectedRoomMap[roomPositionList[index]][i],
              style: TextStyle(fontSize: 12,
              color: ColorUtils.color_labels_light,
              fontFamily:FontFamily.NOTOSANS_REGULAR,
              fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis,
            ));
          }
        } else {
          for (var i = 0;
              i < selectedRoomMap[roomPositionList[index]].length;
              i++) {
            list.add(new Text(
              selectedRoomMap[roomPositionList[index]][i],
              style: TextStyle(fontSize: 12,
              color: ColorUtils.color_labels_light,
              fontFamily:FontFamily.NOTOSANS_REGULAR,
              fontWeight: FontWeight.w400),
              
              overflow: TextOverflow.ellipsis,
            ));
          }
        }
      }
      return new Column(children: list);
    } else {
      return new Container(
        child: CustomTextField(
            isVisible: true,
            text: "No Room\nSelected",
            isBold: false,
            size: 12,
            colors: ColorUtils.color_labels_light,
            fontWeight: FontWeight.w400),
      );
    }
  }

  Widget moreText(index) {
    if (selectedRoomMap[roomPositionList[index]] != null &&
        selectedRoomMap[roomPositionList[index]].length > 2) {
      return CustomTextField(
          isVisible: true,
          text: "+${selectedRoomMap[roomPositionList[index]].length - 2} room",
          isBold: false,
          size: 12,
          colors: ColorUtils.color_labels_light,
          fontWeight: FontWeight.w400);
    } else {
      return CustomTextField(
          isVisible: true,
          text: "",
          isBold: true,
          size: 14,
          colors: ColorUtils.color_labels,
          fontWeight: FontWeight.w600);
    }
  }

  void checkMapSize() {
    selectedRoomMap.forEach((key, value) {
      if (value.length > 0) {
        mapFlag = true;
      } else {
        mapFlag = false;
      }
    });
  }
}
