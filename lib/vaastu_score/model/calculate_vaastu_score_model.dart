class CalculateVaastuScoreModel {
  late String status;
  late int statusCode;
  late String message;
  late Payload payload;

  CalculateVaastuScoreModel(
      {required this.status, required this.statusCode, required this.message, required this.payload});

  CalculateVaastuScoreModel.fromJson(Map<String, dynamic> json) {
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
  late String overallVastuScore;
  late String vastuScoreStatus;
  late List<RoomWiseVastuScore> roomWiseVastuScore;

  Data(
      {required this.overallVastuScore, required this.vastuScoreStatus, required this.roomWiseVastuScore});

  Data.fromJson(Map<String, dynamic> json) {
    overallVastuScore = json['overallVastuScore'];
    vastuScoreStatus = json['vastuScoreStatus'];
    if (json['roomWiseVastuScore'] != null) {
      roomWiseVastuScore = [];
      json['roomWiseVastuScore'].forEach((v) {
        roomWiseVastuScore.add(new RoomWiseVastuScore.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['overallVastuScore'] = this.overallVastuScore;
    data['vastuScoreStatus'] = this.vastuScoreStatus;
    if (this.roomWiseVastuScore != null) {
      data['roomWiseVastuScore'] =
          this.roomWiseVastuScore.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoomWiseVastuScore {
 late String room;
 late String direction;
  late String legend;

  RoomWiseVastuScore({required this.room, required this.direction, required this.legend});

  RoomWiseVastuScore.fromJson(Map<String, dynamic> json) {
    room = json['room'];
    direction = json['direction'];
    legend = json['legend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room'] = this.room;
    data['direction'] = this.direction;
    data['legend'] = this.legend;
    return data;
  }
}
