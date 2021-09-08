import 'package:flutter/material.dart';
import 'package:vastu_machine_test/utility/utils.dart';

class CustomTextField extends StatelessWidget {
  String text;
  bool isBold = false;
  double size;
  Color colors;
  FontWeight fontWeight;
  bool isVisible;

  CustomTextField(
      {required this.isVisible,
      required this.text,
      required this.isBold,
      required this.size,
      required this.colors,
      required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return buildTextField(context);
  }

  Widget buildTextField(context) {
    return Visibility(
      key: UniqueKey(),
      child: Container(
          child: Text(this.text,
              // style: Theme.of(context).textTheme.headline6
              //
              softWrap: true,
              // overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: size, // MediaQuery.of(context).size.width / 16,
                  color: colors,
                  fontWeight: fontWeight,
                  fontFamily: isBold
                      ? FontFamily.NOTOSANS_BOLD
                      : FontFamily.NOTOSANS_REGULAR)
                  )),
      visible: isVisible,
    );
  }
}
