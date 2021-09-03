import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(
      { Key? key,
      required Widget title,
      required bool centerTitle,
      required Color color,
      required Widget rightIcon,
      required Widget leftIcon})
      : super(
            key: key,
            title: title,
            centerTitle: centerTitle,
            actions: <Widget>[rightIcon],
            leading: leftIcon,
            elevation: 0,
            backgroundColor: color,
             shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight:Radius.circular(20))
            ),
            bottom: PreferredSize(
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  color: Colors.white60,
                  height: 1.0,
                ),
                preferredSize: Size.fromHeight(4.0)));

}
