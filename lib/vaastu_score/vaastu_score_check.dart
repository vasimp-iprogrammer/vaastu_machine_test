import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vastu_machine_test/base/base_page.dart';
import 'package:vastu_machine_test/interfaces/common_interface.dart';
import 'package:vastu_machine_test/server/api_auth_repository.dart';
import 'package:vastu_machine_test/utility/preferences.dart';
import 'package:vastu_machine_test/utility/utils.dart';
import 'package:vastu_machine_test/vaastu_score/model/roomlist_response_model.dart';
import 'package:vastu_machine_test/vaastu_score/select_room.dart';
import 'package:vastu_machine_test/widget/custom_image.dart';
import 'package:vastu_machine_test/widget/custom_textfield.dart';

class VaastuScoreCheckScreen extends BasePage{
  @override
  _VaastuScoreCheckScreen createState() => _VaastuScoreCheckScreen();
  
}
class _VaastuScoreCheckScreen extends BaseState<VaastuScoreCheckScreen>
with BasicPage
implements CommonInterface{
  List<String> roomPositionList=["NORTH-WEST","NORTH","NORTH-EAST","WEST",
  "CENTER OF THE HOME","EASR",
  "SOUTH-WEST","SOUTH","SOUTH-EAST"];
  late int checkedIndex=-1;
  Map<String,List<dynamic>> selectedRoomMap={};
  List<dynamic>? temp=[];
  late int tempIndex;
  late SharedPreferences sharedPreferences;

  
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
          CustomTextField(isVisible: true, 
          text: "ROOM SELECTOR", 
          isBold: true, size: 14,
           colors: ColorUtils.color_labels, 
           fontWeight: FontWeight.w600),
          SizedBox(height:10),
            CustomTextField(isVisible: true, 
          text: "Select the room thar are present in each direction of your home by tapping on textboxes below:", 
          isBold: false, size: 12,
           colors: ColorUtils.color_labels, 
           fontWeight: FontWeight.w400),
           SizedBox(height:20),
          getRoomDirection(),
           
        ],),
      ),
    );
  }

  Widget getRoomDirection(){
    return GridView.builder(  
              itemCount: roomPositionList.length,  
              scrollDirection: Axis.vertical,
    shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
                  crossAxisCount: 3,  
                  crossAxisSpacing: 4.0,  
                  mainAxisSpacing: 4.0  
              ),  
              itemBuilder: (BuildContext context, int index){  
                bool checked = index == checkedIndex;
                return InkResponse(
                  onTap: (){
                    setState(() {
        checkedIndex = index;
        
          
      });
                    print(roomPositionList[index]);
                   
                  callNextPage(index);
                  },
                                  child: Card(
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(10)),
           elevation: 10,
         child:Padding(
           padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
           child: Column(children: [
              CustomTextField(isVisible: true, 
        text: roomPositionList[index],
        isBold: true, size: 14,
           colors: checked?ColorUtils.color_red: ColorUtils.color_labels, 
           fontWeight: FontWeight.w600),
           SizedBox(height:10),
            CustomTextField(isVisible: true, 
        text: "No Room\n Selected", 
        
        isBold: false, size: 12,
           colors: checked?ColorUtils.color_red: ColorUtils.color_labels, 
           fontWeight: FontWeight.w400),
        //    ListView.builder(
        //      itemCount: temp!.length,
        //      scrollDirection: Axis.vertical,
        //       physics: ScrollPhysics(),
        //       shrinkWrap: true,
        //      itemBuilder: (context,index2){
        //        return Container(
        //          child: Text(
        //            checkedIndex==index2?
        //            temp![index2]:""
        //            ),
        //        );
        // }
        //    )
        
        for ( var i in temp! )
       
          Text(i.toString()+"\n" )
        
           ],),
         )
       ),
                );  
              },  
            );
  }
  @override
  Widget getBottomWidget() {
    return Container();
  }

  void callNextPage(int index) async{
 List<String> seletedRoom = await Navigator.of(context).push(
                       MaterialPageRoute(
                    builder: (context) => SelectRoomScreen(
                      roomDirection: roomPositionList[index],
                      index: index,),
                  )
                    );
                    setState(() async {
                      print(seletedRoom);
                      selectedRoomMap[roomPositionList[index]]=seletedRoom;
                      await Prefs.setString("selectedRoomMap",json.encode(selectedRoomMap));
                      temp=selectedRoomMap[roomPositionList[index]];
                      print(selectedRoomMap);
                    });
  }

  @override
  void getText(String str, String type) {
      // TODO: implement getText
    }
  
    @override
    initializingObjects()async {
      await Prefs.init();
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
      // TODO: implement onClick
    }
  
    @override
    void onItemSelected(String type, model) {
    // TODO: implement onItemSelected
  }

  @override
  String pageTitle() {
    return APPTITLES.VAASTU_SCORE_CHECK;
  } 


}

// class Choice {  
//   const Choice({required this.title, required this.icon});  
//   final String title;  
//   final IconData icon;  
// }  
  
// const List<Choice> choices = const <Choice>[  
//   const Choice(title: 'Home', icon: Icons.home),  
//   const Choice(title: 'Contact', icon: Icons.contacts),  
//   const Choice(title: 'Map', icon: Icons.map),  
   
// ];  
  
// class SelectCard extends StatelessWidget {  
//   const SelectCard({ Key? key, required this.choice}) : super(key: key);  
//   final Choice choice;  
  
//   @override  
//   Widget build(BuildContext context) {  
//     return Card(  
//         color: Colors.orange,  
//         child: Center(child: Column(  
//             crossAxisAlignment: CrossAxisAlignment.center,  
//             children: <Widget>[  
//               Expanded(child: Icon(choice.icon, size:50.0,)),  
//               Text(choice.title),  
//             ]  
//         ),  
//         )  
//     );  
//   }  
// }  