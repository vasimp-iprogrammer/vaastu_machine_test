import 'package:flutter/material.dart';
import 'package:vastu_machine_test/server/api_auth_provider.dart';
import 'package:vastu_machine_test/vaastu_score/model/roomlist_response_model.dart';

class ApiAuthRepository {
  BuildContext context;
  static late ApiAuthProvider _apiAuthProvider;

  ApiAuthRepository(this.context) {
    _apiAuthProvider = ApiAuthProvider(context: context);
  }
  Future<RoomListResponse> getRoomList() =>
      _apiAuthProvider.getRoomList();
}