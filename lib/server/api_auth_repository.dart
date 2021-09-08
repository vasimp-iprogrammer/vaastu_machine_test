import 'package:flutter/material.dart';
import 'package:vastu_machine_test/server/api_auth_provider.dart';
import 'package:vastu_machine_test/vaastu_score/model/calculate_vaastu_score_model.dart';
import 'package:vastu_machine_test/vaastu_score/model/direction_details_response.dart';
import 'package:vastu_machine_test/vaastu_score/model/room_details_response.dart';
import 'package:vastu_machine_test/vaastu_score/model/roomlist_response_model.dart';

class ApiAuthRepository {
  BuildContext context;
  static late ApiAuthProvider _apiAuthProvider;

  ApiAuthRepository(this.context) {
    _apiAuthProvider = ApiAuthProvider(context: context);
  }
  Future<RoomListResponse> getRoomList() =>
      _apiAuthProvider.getRoomList();

  Future<CalculateVaastuScoreModel> getCalculateVaastuScore(var dataBody)=>
  _apiAuthProvider.getCalculateVaastuScore(dataBody);

  Future<RoomDetailseResponse> getRoomDetails(var resBody)=>
  _apiAuthProvider.getRoomDetails(resBody);

   Future<DirectionDetailsResponse> getDirectionDetails(var resBody)=>
  _apiAuthProvider.getDirectionDetails(resBody);
}