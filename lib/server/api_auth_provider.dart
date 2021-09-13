import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vastu_machine_test/utility/utils.dart';
import 'package:vastu_machine_test/vaastu_score/model/calculate_vaastu_score_model.dart';
import 'package:vastu_machine_test/vaastu_score/model/direction_details_response.dart';
import 'package:vastu_machine_test/vaastu_score/model/room_details_response.dart';
import 'package:vastu_machine_test/vaastu_score/model/roomlist_response_model.dart';
import 'package:http/http.dart' as http;

class ApiAuthProvider{
  final Dio _dio = new Dio();
  BuildContext context;
  late http.Response response;
  ApiAuthProvider({required this.context}) {
    _dio.options.baseUrl = ApiEndPoints.BASE_URL;
  }

  // Future<RoomListResponse> getRoomList() async {
  //   var roomResponse;
  //   try {
  //     final response = await _dio.post(
  //        ApiEndPoints.BASE_URL+ApiEndPoints.ROOMLIST,
  //         data: {},
  //         );
  //     print("url -= ${ApiEndPoints.BASE_URL+ApiEndPoints.ROOMLIST}");
  //     print("ApiEndPoints--$response");
  //     roomResponse = response;
  //     return RoomListResponse.fromJson(response.data);
  //   } catch (error, stacktrace) {
  //     print("object${error.toString()}");
  //   }
  //   return roomResponse;
  // }

  Future<RoomListResponse> getRoomList() async{
     //var client = http.Client();
    response = await http.get(Uri.parse(ApiEndPoints.BASE_URL+ApiEndPoints.ROOMLIST));
      final res= json.decode(response.body);
  //  debugPrint(res.toString());
    return RoomListResponse.fromJson(res);
  }
  Future<CalculateVaastuScoreModel>getCalculateVaastuScore(var dataBody)async{
    response = await http.post(Uri.parse(ApiEndPoints.BASE_URL
    +ApiEndPoints.VAASTU_SCORE),
    body: JsonEncoder().convert(dataBody));
    final res= json.decode(response.body);
    debugPrint(res.toString());
    return CalculateVaastuScoreModel.fromJson(res);
  }
  Future<RoomDetailseResponse> getRoomDetails(var roomName)async{
    response = await http.post(Uri.parse(ApiEndPoints.BASE_URL
    +ApiEndPoints.VAASTU_ROOM_DETAILS),
    body: JsonEncoder().convert(roomName));
    final res=json.decode(response.body);
    debugPrint(res.toString());
    return RoomDetailseResponse.fromJson(res);

  }

  Future<DirectionDetailsResponse> getDirectionDetails(var directionName)async{
    debugPrint("direc $directionName");
    response = await http.post(Uri.parse(ApiEndPoints.BASE_URL
    +ApiEndPoints.VAASTU_DIRECTION_DETAILS),
    body: JsonEncoder().convert(directionName));
    final res=json.decode(response.body);
    debugPrint(res.toString());
    return DirectionDetailsResponse.fromJson(res);

  }
}