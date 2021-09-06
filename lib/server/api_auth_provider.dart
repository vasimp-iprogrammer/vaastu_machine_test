import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vastu_machine_test/utility/utils.dart';
import 'package:vastu_machine_test/vaastu_score/model/roomlist_response_model.dart';
import 'package:http/http.dart' as http;

class ApiAuthProvider{
  final Dio _dio = new Dio();
  BuildContext context;
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
   http.Response response = await http.get(Uri.parse(ApiEndPoints.BASE_URL+ApiEndPoints.ROOMLIST));
      final res= json.decode(response.body);
    debugPrint(res.toString());
    return RoomListResponse.fromJson(res);
  }
}