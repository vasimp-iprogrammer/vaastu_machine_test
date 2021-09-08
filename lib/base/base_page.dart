import 'package:flutter/material.dart';
import 'package:vastu_machine_test/base/custom_appbar.dart';
import 'package:vastu_machine_test/utility/utils.dart';
import 'package:vastu_machine_test/widget/custom_textfield.dart';

abstract class BasePage extends StatefulWidget {
  BasePage({Key? key}) : super(key: key);
}

abstract class BaseState<Page extends BasePage> extends State<Page> {
   initializingObjects();

  Widget body();

  isAppBarVisible();

  String pageTitle();

  isNaviagtionDrawerVisible();

  Widget appBarLeftIcon();

  Widget appBarRightIcon();

  bool isBottomNavigationIsible();

  Widget getBottomWidget();

  Color backgroundColor();

  onBackPressed(context);
  
}
mixin BasicPage<Page extends BasePage> on BaseState<Page> {
   @override
  void initState() {
    initializingObjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: isAppBarVisible()
          ? CustomAppBar(
              title: CustomTextField(
                isVisible: true,
                text: pageTitle(),
                colors: Colors.white,
                fontWeight: FontWeight.w500,
                size: 17,
                isBold: true,
              ),
              color: ColorUtils.color_app_bar,
              leftIcon: appBarLeftIcon(),
              rightIcon: appBarRightIcon(),
              centerTitle: true, 
            )
          : null,
        body: WillPopScope(
            onWillPop: () => onBackPressed(context),
            
          child: body(),
          
        ),
         bottomNavigationBar: Visibility(
        visible: isBottomNavigationIsible(),
        child: BottomAppBar(
          elevation: 0.0,
          color: Colors.white,
          child: getBottomWidget(),
        ),
      ),
      //  backgroundColor: ColorUtils.color_app_bg,
        );
  }

  //Widget body();
}