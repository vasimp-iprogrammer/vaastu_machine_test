import 'dart:convert';

RoomListResponse infinityResponseFromJson(String str) =>
    RoomListResponse.fromJson(json.decode(str));

String infinityResponseToJson(RoomListResponse data) =>
    json.encode(data.toJson());
class RoomListResponse {
  late String status;
  late int statusCode;
  late String message;
  late Payload payload;

  RoomListResponse({required this.status, required this.statusCode, required this.message, required this.payload});

  RoomListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    payload =
        (json['payload'] != null ? new Payload.fromJson(json['payload']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.payload != null) {
      data['payload'] = this.payload.toJson();
    }
    return data;
  }
}

class Payload {
 late Data data;

  Payload({required this.data});

  Payload.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  late List<String> roomList;

  Data({required this.roomList});

  Data.fromJson(Map<String, dynamic> json) {
    roomList = json['roomList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomList'] = this.roomList;
    return data;
  }
}