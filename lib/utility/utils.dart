import 'package:flutter/material.dart';

class ColorUtils {
  static const Color color_light_grey = Color(0xffececec);
  static const Color color_app_bg=Color(0xffE5E5E5);
  static const Color color_app_bar = Color(0xff513796);
  static const Color color_red=Color(0xffFF7021);
  static const Color color_lite_app = Color(0xff4ed619);
  static const Color color_button = Color(0xffe7e7e7);
  static const Color color_black = Color(0xff303030);
  static const Color color_card_50 = Color(0xff4cb8dc);
  static const Color color_card_100 = Color(0xffff6d5e);
  static const Color color_card_75 = Color(0xffecac48);
  static const Color color_card_25 = Color(0xffb4b6ba);
  static const Color color_labels = Color(0xff666666);
  static const Color color_labels_light = Color(0xff999999);
  static const Color color_white = Color(0xffFFFFFF);
  static const Color color_yello = Color(0xffffb82d);
  static const Color color_light_green = Color(0xffb6eea2);
  static const Color color_grey_bg = Color(0xfff1f1f1);

  static const Color color_NEW = Color(0xff4cb8dc);
  static const Color color_IN_PROGRESS = Color(0xffffb82d);
  static const Color color_FINALIZED = Color(0xffff6d5e);
  static const Color color_DELIEVERD = Color(0xff4ed619);
  static const Color color_CANCELLED = Colors.red;

  Color newButtonColor = Color.fromRGBO(76, 184, 220, 10);
  Color dispatchedButtonColor = Color.fromRGBO(66, 196, 21, 10);
  Color inProgressButtonColor = Color.fromRGBO(255, 188, 83, 10);
  Color dividerColor = Color.fromRGBO(231, 231, 231, 10);
  Color textLightBlackColor = Color.fromRGBO(48, 48, 48, 10);
  Color textLigtGreyColor = Color.fromRGBO(166, 162, 162, 10);

  static const Color color_MISSING_RESTAURANT = Colors.red;
  static Color color_MISSING_BIN = Colors.lime.shade800;
  static Color color_MISSING_WC = Colors.pinkAccent.shade700;
  static Color color_WITH_CUSTOMER = Colors.lightGreenAccent;
  static Color color_WITH_COLLECTINGAENT = Colors.deepPurpleAccent.shade200;
  static const Color color_AVAILABLE = Colors.cyan;
  static const Color color_IN_BATCH = Colors.purpleAccent;
  static const Color color_IN_RESATAURANT = Colors.brown;
  static const Color color_WITH_GC = Colors.blueGrey;
  static const Color color_IN_SMARTBIN = Colors.lime;
  static const Color color_WASHED = Colors.amber;
  static const Color color_MISSING_GC = Colors.black;
  static const Color color_MISSING_QRCODE = Colors.yellow;
  static const Color color_MISSING_DAMAGED = Colors.lightBlue;
  static const Color color_IN_RECIVED_BATCH_DEFAULT = Colors.deepOrangeAccent;
  static const Color color_MARK_AS_RECIVED = Colors.teal;
  static const Color color_IN_WASHINH_CENTER = Colors.pinkAccent;
}
class APPTITLES{
  static String HOME_PAGE="Vaastu Check";
  static String VAASTU_SCORE_CHECK="Vaastu Score Check";
  static String COMPASS_TOOL="Compass Tool";

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
}
class ApiEndPoints{
  static String BASE_URL = "https://luayn58dm9.execute-api.ap-south-1.amazonaws.com/stage/";
  static String ROOMLIST = "vastu/getRoomList";
}