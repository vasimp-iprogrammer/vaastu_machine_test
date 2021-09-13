import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
//import 'package:infinitybox/view/widget/progress_dialog.dart';
//import 'package:progress_dialog/progress_dialog.dart';

class CustomProgressDialog {
  late ProgressDialog _progressDialog;
  late BuildContext context;
  CustomProgressDialog({required BuildContext context}) {
    _progressDialog = ProgressDialog(context, isDismissible: false);
    _progressDialog.style(
      message: 'Please wait...',
    );
    // this.context=context;
    // _progressDialog = ProgressDialog();
  }

  showProgressDialog() {
    _progressDialog.show();
    // _progressDialog.showPorgressDialog(context);
  }

  hideProgressDialog() {
    Future.delayed(Duration(seconds: 1)).then((onValue) {
      if (_progressDialog.isShowing())
        _progressDialog.hide().then((isHidden) {
          print(isHidden);
        });
    });

    //_progressDialog.hideProgressDialog(context);
  }

  isSHowing() {
    return _progressDialog.isShowing();
  }
}
