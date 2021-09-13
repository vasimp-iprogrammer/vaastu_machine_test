import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vastu_machine_test/base/base_page.dart';
import 'package:vastu_machine_test/enums/connectivity_status.dart';
import 'package:vastu_machine_test/interfaces/common_interface.dart';
import 'package:vastu_machine_test/server/api_auth_repository.dart';
import 'package:vastu_machine_test/utility/utils.dart';
import 'package:vastu_machine_test/vaastu_score/model/direction_details_response.dart';
import 'package:vastu_machine_test/widget/custom_image.dart';
import 'package:vastu_machine_test/widget/custom_progress_dialog.dart';
import 'package:vastu_machine_test/widget/custom_textfield.dart';

class DirectionDetailsSCreen extends BasePage {
  String roomDirection;
  @override
  _DirectionDetailsSCreen createState() => _DirectionDetailsSCreen();
  DirectionDetailsSCreen({required this.roomDirection});
}

class _DirectionDetailsSCreen extends BaseState<DirectionDetailsSCreen>
    with BasicPage
    implements CommonInterface {
  var title;
  String about = "";
  List<String> favourableDirections = [];
  late CustomProgressDialog customProgressDialog;
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
    return Container();
  }

  @override
  Color backgroundColor() {
    return ColorUtils.color_white;
  }

  @override
  Widget body() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ABOUT",
                style: TextStyle(
                    color: ColorUtils.color_labels,
                    fontFamily: FontFamily.NOTOSANS_BOLD,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0),
              ),
              SizedBox(height: 10),
              CustomTextField(
                  isVisible: true,
                  text: about == "" ? 'No Data' : about,
                  isBold: false,
                  size: 12,
                  colors: ColorUtils.color_labels,
                  fontWeight: FontWeight.w600),
              SizedBox(height: 10),
              Text(
                "Favourable rooms".toUpperCase(),
                style: TextStyle(
                    color: ColorUtils.color_labels,
                    fontFamily: FontFamily.NOTOSANS_BOLD,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0),
              ),
              favourableDirections.length>0
              ? showRoomList(favourableDirections)
              : Text("No Data ",)
            ]),
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
    title = widget.roomDirection.toString();
    Constants.check().then((intenet) {
      if (intenet != null && intenet) {
         Future.delayed(Duration.zero, () {
           getDirectionDetails(title);
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
    return title;
  }

  void getDirectionDetails(var direction) {
    customProgressDialog = CustomProgressDialog(context: context);
    customProgressDialog.showProgressDialog();
    var resBody = {};
    resBody["direction"] = direction;
    print("direct $resBody");
    getResponse(resBody).then((value) {
      customProgressDialog.hideProgressDialog();
      setState(() {
        about = value.payload.data.aboutDescription;
        favourableDirections = value.payload.data.favourableDirections;
      });
    });
  }

  Future<DirectionDetailsResponse> getResponse(var resBody) {
    return ApiAuthRepository(context).getDirectionDetails(resBody);
  }

  Widget showRoomList(List<String> favourableDirections) {
    return ListView.builder(
        itemCount: favourableDirections.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              CustomImage(
                size: 7,
                assetPath: ASSETUTILS.ASSETS_PINTER,
                commonInterface: this,
                type: SourceType.BACK.toString(),
              ),
              CustomTextField(
                  isVisible: true,
                  text: favourableDirections[index],
                  isBold: false,
                  size: 14,
                  
                  colors: ColorUtils.color_labels,
                  fontWeight: FontWeight.w400),
            ],
          );
        });
  }
}
