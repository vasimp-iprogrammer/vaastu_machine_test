import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:ui';

import 'package:vastu_machine_test/base/base_page.dart';
import 'package:vastu_machine_test/enums/connectivity_status.dart';
import 'package:vastu_machine_test/interfaces/common_interface.dart';
import 'package:vastu_machine_test/server/api_auth_repository.dart';
import 'package:vastu_machine_test/utility/utils.dart';
import 'package:vastu_machine_test/vaastu_score/model/roomlist_response_model.dart';
import 'package:vastu_machine_test/vaastu_score/view/direction_details_screen.dart';
import 'package:vastu_machine_test/widget/custom_button.dart';
import 'package:vastu_machine_test/widget/custom_image.dart';
import 'package:vastu_machine_test/widget/custom_progress_dialog.dart';
import 'package:vastu_machine_test/widget/custom_textfield.dart';

class SelectRoomScreen extends BasePage{
  late String roomDirection;
  late int index;
  late List<dynamic> prevSelectedRoomList;
 @override
  _SelectRoomScreen createState() => _SelectRoomScreen();
  SelectRoomScreen({required this.roomDirection,
  required this.index,
  required this.prevSelectedRoomList});
}
class _SelectRoomScreen extends BaseState<SelectRoomScreen>
with BasicPage
implements CommonInterface{
  String roomDirection="";
  late int index;
 
 late List<bool> _isChecked=[];
  List<dynamic> roomList=[];
  List<dynamic> selectedRoomList=[];
  List<dynamic> prevSelectedRoomList=[];
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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(children: [
                  Expanded(
                    flex: 1,
                                    child: CustomTextField(
                                              isVisible: true,
                                              text: "Want to konw more about $roomDirection ?",
                                              colors: ColorUtils.color_labels,
                                              fontWeight: FontWeight.w600,
                                              size: 14,
                                              isBold: false,
                                            ),
                  ),
                                          GestureDetector(
                                                onTap: (){
                                                  Navigator.of(context).push(
                                                  MaterialPageRoute(builder: 
                                                  (context)=>DirectionDetailsSCreen(roomDirection: roomDirection))  
                                                  
                                                  );
                                                },                                     
                                            //  child: CustomTextField(
                                            //   isVisible: true,
                                            //   text: "READ NOW",
                                            //   colors: ColorUtils.color_red,
                                            //   fontWeight: FontWeight.bold,
                                            //   size: 14,
                                            //   isBold: true,
                                            // ),
                                            child: Text("READ NOW",
                    style: TextStyle(
                      color: ColorUtils.color_red,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.NOTOSANS_BOLD,
                      fontSize: 15,
                      letterSpacing: 1.0)),
                                          ),
                ],),
              ),
              Divider(
                color:ColorUtils.color_black
              ),
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Align(
                   alignment: Alignment.centerLeft,
                                child: CustomTextField(
                                                  isVisible: true,
                                                  text: "Select multiple room that are present in this direction: ",
                                                  colors: ColorUtils.color_labels,
                                                  fontWeight: FontWeight.w600,
                                                  size: 14,
                                                  isBold: false,
                                                ),
                 ),
               ),
               getApiList()
            ],
          ),
        ),
   );
  }
  void getRoomList()async{
     customProgressDialog = CustomProgressDialog(context: context);
    await customProgressDialog.showProgressDialog();
  getResponse().then((value) {
    setState(() {
      customProgressDialog.hideProgressDialog();
      roomList.clear();
      roomList.addAll(value.payload.data.roomList);
     
       _isChecked = List<bool>.filled(roomList.length, false);
    });
  });
}

  Future<RoomListResponse> getResponse(){
    return ApiAuthRepository(context).getRoomList();
  }

  @override
  Widget getBottomWidget() {
    return GestureDetector(
          onTap: (){
            
             Navigator.of(context).pop(selectedRoomList); 
          },
          child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(
                    topLeft:Radius.circular(10),
                    topRight:Radius.circular(10)
                  ),
                   color: ColorUtils.color_red,),
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                      Text("SELECT ROOMS",
                        style: TextStyle(color: ColorUtils.color_white,
                        fontSize: 16),),
                     
                    ],
                  )),
    );
  }
@override
  void initState() {
    super.initState();
    roomDirection = widget.roomDirection.toString();
    index=widget.index;
    prevSelectedRoomList = widget.prevSelectedRoomList;
   // print("data "+roomDirection);
    if(prevSelectedRoomList.isNotEmpty)
    selectedRoomList.addAll(prevSelectedRoomList);
 //   if(prevSelectedRoomList.isEmpty){
   Future.delayed(Duration.zero, () {
      getRoomList();
   });
        
    // }else{
    //   roomList.clear();
    //   roomList.addAll(prevSelectedRoomList);
    // }
    
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
    return true;
  }

  @override
  isNaviagtionDrawerVisible() {
   return false;
  }

  @override
  onBackPressed(context) {
   Navigator.of(context).pop(selectedRoomList);
  }

  @override
  String pageTitle() {
   // print("page title "+roomDirection);
    return roomDirection;
  }

  @override
  void getText(String str, String type) {
      // TODO: implement getText
    }
  
    @override
    void onClick(String type) {
      if(type==SourceType.BACK.toString()){
          Navigator.of(context).pop(selectedRoomList);
        }
    }
  
    @override
    void onItemSelected(String type, model) {
    // TODO: implement onItemSelected
  }
  Widget getApiList(){
    return  ListView.builder(
              itemCount: roomList.length,
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    CheckboxListTile(
                       value: prevSelectedRoomList.contains(roomList[index])?true: _isChecked[index],
                      title: Text(roomList[index],
                      style: TextStyle(color: ColorUtils.color_room_list_labels),),
                     controlAffinity: ListTileControlAffinity.leading,
                     activeColor: ColorUtils.color_red,
                    
                      onChanged: (val) {
                        setState(
                          () {
                            _isChecked[index] = val!;
                           
                            if(val==true){
                              if(roomList.length>0&& !selectedRoomList.contains(roomList[index]))
                              selectedRoomList.add(roomList[index]);
                            }else{
                              if(selectedRoomList.length>0 && selectedRoomList.contains(roomList[index]))
                                selectedRoomList.remove(roomList[index]);
                                prevSelectedRoomList.remove(roomList[index]);
                            }

                            
                          },
                        );
                      },
                    ),
                    Divider(
                      color: ColorUtils.color_black,
                    ),
                  ],
                );
              },
      );
  }
  

}