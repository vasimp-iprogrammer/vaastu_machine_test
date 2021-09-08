import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:ui';

import 'package:vastu_machine_test/base/base_page.dart';
import 'package:vastu_machine_test/enums/connectivity_status.dart';
import 'package:vastu_machine_test/interfaces/common_interface.dart';
import 'package:vastu_machine_test/server/api_auth_repository.dart';
import 'package:vastu_machine_test/utility/utils.dart';
import 'package:vastu_machine_test/vaastu_score/model/room_details_response.dart';
import 'package:vastu_machine_test/widget/custom_image.dart';
import 'package:vastu_machine_test/widget/custom_textfield.dart';

class RoomDetailsScreen extends BasePage{
  var title="";
  @override
 _RoomDetailsScreen createState() =>_RoomDetailsScreen();
 RoomDetailsScreen({required this.title});
  
}
class _RoomDetailsScreen extends BaseState<RoomDetailsScreen>
with BasicPage
implements CommonInterface{
  late String title;
  late List<String> favourableDirections=[];
 late List<String> neutralDirections=[];
 late List<String> unfavourableDirections=[];
 late String aboutDescription="";
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
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text("FAVOURABLE DIRECTIONS",
                      style: TextStyle(
                        color: ColorUtils.color_labels,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 1.0),),
           SizedBox(height:0),           
           showGrid('favourableDirections',favourableDirections),
          //showslist('favourableDirections',favourableDirections),
           SizedBox(height:20),    
          Text("NEUTRAL DIRECTIONS",
                      style: TextStyle(
                        color: ColorUtils.color_labels,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 1.0),),
          SizedBox(height:20),   
          showGrid('neutralDirections',neutralDirections),
          // showslist('neutralDirections', neutralDirections),
           SizedBox(height:20),                
          Text("UNFAVOURABLE DIRECTIONS",
                      style: TextStyle(
                        color: ColorUtils.color_labels,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 1.0),),
          SizedBox(height:20), 
          //  getList("favourableDirections", favourableDirections),
          showGrid('unfavourableDirections',unfavourableDirections),
           SizedBox(height:20),    
          Text("ABOUT",
                      style: TextStyle(
                        color: ColorUtils.color_labels,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 1.0),),
          SizedBox(height:20),       
          CustomTextField(
                                        isVisible: true,
                                        text: aboutDescription,
                                        colors: ColorUtils.color_vaastu_score_label,
                                        fontWeight: FontWeight.bold,
                                        size: 14,
                                        isBold: true,
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
  void getText(String str, String type) {
      // TODO: implement getText
    }
  
    @override
    initializingObjects() {
     title=widget.title.toString();
     getRoomDetails(title);

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
      if(type==SourceType.BACK.toString()){
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

  void getRoomDetails(var roomName){
    var resBody = {};
     resBody["roomName"] = roomName;
     getResponse(resBody).then((value){
       setState(() {
          favourableDirections=value.payload.data.favourableDirections;
      neutralDirections=value.payload.data.neutralDirections;
      unfavourableDirections=value.payload.data.unfavourableDirections;
      aboutDescription = value.payload.data.aboutDescription;
       });
     
     });
  }
  Future<RoomDetailseResponse> getResponse(var resBody){
    return ApiAuthRepository(context).getRoomDetails(resBody);
  }


   
    Widget showGrid(String type,List<String> roomList){
      return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: 3,
      childAspectRatio: 3,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: roomList.map((value) {
        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: type=='unfavourableDirections'?ColorUtils.color_unfavourate_bg
            :type=='favourableDirections'?ColorUtils.color_favourate_bg
            :type=='neutralDirections'?ColorUtils.color_netural_bg
            :ColorUtils.color_white,),
          child: Text(value,
          style: TextStyle(fontFamily: FontFamily.NOTOSANS_BOLD,
          color:type=='unfavourableDirections'?ColorUtils.color_pink_red
            :type=='favourableDirections'?ColorUtils.color_favourate
            :type=='neutralDirections'?ColorUtils.color_netural
            :ColorUtils.color_white, 
            fontSize: 15,
            fontWeight: FontWeight.bold),),
        );
      }).toList(),
    );
    }
}
