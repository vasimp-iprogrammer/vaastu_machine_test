import 'package:flutter/material.dart';

import 'package:vastu_machine_test/interfaces/common_interface.dart';

class CustomImage extends StatelessWidget {
  double size;
  String assetPath;
  CommonInterface commonInterface;
  String type;

  CustomImage(
      {required this.size,
      required this.assetPath,
      required this.commonInterface,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (commonInterface != null) commonInterface.onClick(type);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 0, right: 0, bottom: 15),
        child: new SizedBox(
          height: size,
          width: 40,
          child: Image.asset(assetPath),
        ),
      ),
    );
  }
}
