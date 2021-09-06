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
import 'package:vastu_machine_test/widget/custom_button.dart';
import 'package:vastu_machine_test/widget/custom_image.dart';
import 'package:vastu_machine_test/widget/custom_progress_dialog.dart';
import 'package:vastu_machine_test/widget/custom_textfield.dart';

class SelectRoomScreen extends BasePage{
  late String roomDirection;
  late int index;
 @override
  _SelectRoomScreen createState() => _SelectRoomScreen();
  SelectRoomScreen({required this.roomDirection,required this.index});
}
class _SelectRoomScreen extends BaseState<SelectRoomScreen>
with BasicPage
implements CommonInterface{
  String roomDirection="";
  late int index;
  List<String> _texts = [
    "InduceSmile.com",
    "Flutter.io",
    "google.com",
    "youtube.com",
    "yahoo.com",
    "gmail.com"
  ];
 late List<bool> _isChecked;
  List<String> roomList=[];
  List<String> selectedRoomList=[];
  @override
  Widget appBarLeftIcon() {
  return CustomImage(
           size: 12,
           assetPath: ASSETUTILS.ASSETS_ARROW_LEFT,
            commonInterface: this,
           type: '',
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
                                          CustomTextField(
                                            isVisible: true,
                                            text: "READ NOW",
                                            colors: ColorUtils.color_red,
                                            fontWeight: FontWeight.bold,
                                            size: 14,
                                            isBold: true,
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
              ListView.builder(
              itemCount: roomList.length,
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    CheckboxListTile(
                       value: _isChecked[index],
                      title: Text(roomList[index]),
                     controlAffinity: ListTileControlAffinity.leading,
                     activeColor: ColorUtils.color_red,
                    
                      onChanged: (val) {
                        setState(
                          () {
                            _isChecked[index] = val!;
                            print(_isChecked[index]);
                            print(roomList[index]);
                            if(val==true){
                              if(roomList.length>0&& !selectedRoomList.contains(roomList[index]))
                              selectedRoomList.add(roomList[index]);
                            }else{
                              if(selectedRoomList.length>0 && selectedRoomList.contains(roomList[index]))
                                selectedRoomList.remove(roomList[index]);
                            }

                            print(selectedRoomList);
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
      ),
            ],
          ),
        ),
   );
  }
  void getRoomList()async{
    //  CustomProgressDialog customProgressDialog = CustomProgressDialog(context: context);
    // await customProgressDialog.showProgressDialog();
  getResponse().then((value) {
    setState(() {
     // customProgressDialog.hideProgressDialog();
      roomList.clear();
      roomList.addAll(value.payload.data.roomList);
      print("list ${roomList.length}");
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
                        fontSize: 12),),
                     
                    ],
                  )),
    );
  }
@override
  void initState() {
    super.initState();
    roomDirection = widget.roomDirection.toString();
    index=widget.index;
    print("data "+roomDirection);
    
     getRoomList();
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
   Navigator.of(context).pop();
  }

  @override
  String pageTitle() {
    print("page title "+roomDirection);
    return roomDirection;
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