import 'package:flutter/material.dart';
import 'package:vastu_machine_test/interfaces/common_interface.dart';
import 'package:vastu_machine_test/utility/utils.dart';

class CustomButton extends StatelessWidget {
  String text;
  bool isValidated;
  bool isImageRequired;
  CommonInterface commonInterface;
  String typeOfClick;
  Color buttonColor;
  Color textColor;
  String assets;

  CustomButton(
      {required this.text,
      required this.isValidated,
      required this.isImageRequired,
      required this.commonInterface,
      required this.typeOfClick,
      required this.buttonColor,
      required this.textColor,
       required this.assets});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: isImageRequired == false
          ? Container()
          : new Padding(
              padding:
                  const EdgeInsets.only(top: 15, left: 0, right: 0, bottom: 15),
              child: new SizedBox(
                height: 25,
                width: 18,
                
              ),
            ),
      label: Flexible(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: textColor,
              ),
        ),
      ),
      style: ElevatedButton.styleFrom(
          primary: buttonColor,
          side: isValidated
              ? BorderSide(color: ColorUtils.color_app_bar, width: 0.5)
              : BorderSide(color: ColorUtils.color_labels, width: 0.6)),
      onPressed: () {
        commonInterface.onClick(typeOfClick);
      },
      onLongPress: () {},
    );
  }
}
