import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vastu_machine_test/base/base_page.dart';
import 'package:vastu_machine_test/enums/connectivity_status.dart';
import 'package:vastu_machine_test/interfaces/common_interface.dart';
import 'package:vastu_machine_test/utility/utils.dart';
import 'package:vastu_machine_test/widget/custom_image.dart';
import 'package:vastu_machine_test/widget/custom_textfield.dart';

class CompassToolScreen extends BasePage{ 
  @override
  _CompassToolScreen createState() => _CompassToolScreen();

}
class _CompassToolScreen extends BaseState<CompassToolScreen> 
with BasicPage 
implements CommonInterface{
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
  Color backgroundColor() =>ColorUtils.color_white;

  @override
  Widget body() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: SingleChildScrollView(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
          Text("ROOM SELECTION",
                    style: TextStyle(
                      color: ColorUtils.color_labels,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 1.0),),
                            SizedBox(height:10),
          Row(children: [
             Expanded(
             
                        child: CustomTextField(
                                isVisible: true,
                                text: "None",
                                colors:Colors.grey,
                                fontWeight: FontWeight.bold,
                                size: 14,
                                isBold: true,
                              ),
             ),
                             Expanded(
                               
                                child: Align(
                        
                                  alignment: Alignment.centerRight,
                                   child: CustomTextField(
                                  isVisible: true,
                                  text: "SELECT A ROOM",
                                  colors: ColorUtils.color_red,
                                  fontWeight: FontWeight.bold,
                                  size: 14,
                                  isBold: true,
                            ),
                                ),
                             ),
          ],)     ,
          SizedBox(height:10),
          Divider(
                          color: ColorUtils().dividerColor,
                          height: 3,
                          thickness: 1,
                        ),   
                        SizedBox(height:50),
                        Center(
                          child: Column(
                              
                            children: [
                            ClipRRect(
                              child: Image.asset(ASSETUTILS.ASSETS_COMPASS_LOC, fit: BoxFit.contain),

                            ),
                      SizedBox(height:5),
             ClipRRect(
                              child: Image.asset(ASSETUTILS.ASSETS_COMPASS_ARROW, fit: BoxFit.contain),

                            ),
            ClipRRect(
                              child: Image.asset(ASSETUTILS.ASSETS_COMPASS, fit: BoxFit.contain),

                            ),   
                            
                          ],),
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
  initializingObjects() {
   
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
     Navigator.of(context).pop(false);
  }

  @override
  String pageTitle() {
  return APPTITLES.COMPASS_TOOL;
  }

  @override
  void getText(String str, String type) {
      // TODO: implement getText
    }
  
    @override
    void onClick(String type) {
      if(type==SourceType.BACK.toString()){
        Navigator.of(context).pop();
      }
    }
  
    @override
    void onItemSelected(String type, model) {
    // TODO: implement onItemSelected
  }

}