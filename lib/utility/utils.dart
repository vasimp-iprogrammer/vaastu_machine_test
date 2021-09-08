import 'package:flutter/material.dart';

class ColorUtils {
  static const Color color_light_grey = Color(0xffececec);
  static const Color color_app_bg=Color(0xffE5E5E5);
  static const Color color_app_bar = Color(0xff513796);
  static const Color color_vaastu_score_label = Color(0xff503796);
  static const Color color_red=Color(0xffFF7021);
  static const Color color_pink_red=Color(0xffD11E4C);
  static const Color color_divider=Color(0xffE2E2E2);
  static const Color color_favourate_bg=Color(0xffF1FBF2);
  static const Color color_unfavourate_bg=Color(0xffFAE8ED);
  static const Color color_netural_bg=Color(0xffFFFAE6);
  static const Color color_favourate=Color(0xff15B525);
  static const Color color_netural=Color(0xffFFCD02);
  static const Color color_white = Color(0xffFFFFFF);
  static const Color color_black = Color(0xff303030);
  static const Color color_labels = Color(0xff666666);
 static const Color color_calcul_score=Color(0xffCCCCCC);
 static const Color color_labels_light = Color(0xff999999);
 Color dividerColor = Color.fromRGBO(231, 231, 231, 10);
 static const Color color_room_list_labels = Color(0xff333333);



 
}
class APPTITLES{
  static String HOME_PAGE="Vaastu Check";
  static String VAASTU_SCORE_CHECK="Vaastu Score Check";
  static String COMPASS_TOOL="Compass Tool";
  static String VAASTU_SCORE="Vaastu Score";

}

class ASSETUTILS{
  static String ASSETS_BACK = "assets/icons/ic_back.jpg";
  static String ASSETS_COMPASS_TOOl = "assets/icons/compass_tool.jpg";
  static String ASSETS_VAASTU_SCRORE= "assets/icons/vaastu_score_check.png";
  static String ASSETS_COMPASS_TAG= "assets/icons/compass_tag.png";
  static String ASSETS_COMPASS_LOC= "assets/icons/compass_loc.png";
  static String ASSETS_COMPASS_ARROW= "assets/icons/compass_arrow.png";
  static String ASSETS_COMPASS= "assets/icons/compass.png";
  static String ASSETS_ARROW_LEFT= "assets/icons/arrow_left.png";
  static String ASSETS_ARROW_LIKE= "assets/icons/like.png";
  static String ASSETS_ARROW_VIEW= "assets/icons/view.png";
  static String ASSETS_SCORE_BOTTOM="assets/icons/vaastu_score_bottom.png";
  static String ASSETS_PINTER="assets/icons/pointer.png";
  static String ASSETS_COMPASS_SMALL="assets/icons/compass_small.png";
  static String ASSETS_PICK="assets/icons/pick.png";
  static String ASSETS_CLOSE="assets/icons/close.png";
}
class ApiEndPoints{
  static String BASE_URL = "https://luayn58dm9.execute-api.ap-south-1.amazonaws.com/stage/";
  static String ROOMLIST = "vastu/getRoomList";
  static String VAASTU_SCORE="vastu/getVastuScore";
  static String VAASTU_ROOM_DETAILS="vastu/getRoomDetails";
   static String VAASTU_DIRECTION_DETAILS="vastu/getDirectionDetails";
}
class Constants{
  static String SELECTED_ROOM_MAP="selectedRoomMap";
}
class FontFamily {
  static String NOTOSANS_BOLD = 'NotoSans-Bold';
  static String NOTOSANS_REGULAR = 'NotoSans-Regular';
}