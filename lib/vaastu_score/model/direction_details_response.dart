class DirectionDetailsResponse {
  late String status;
  late int statusCode;
 late String message;
  late Payload payload;

  DirectionDetailsResponse(
      {required this.status, required this.statusCode, required this.message, required this.payload});

  DirectionDetailsResponse.fromJson(Map<String, dynamic> json) {
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
 late List<String> favourableDirections;
 late String aboutDescription;

  Data({required this.favourableDirections, required this.aboutDescription});

  Data.fromJson(Map<String, dynamic> json) {
    favourableDirections = json['favourableDirections'].cast<String>();
    aboutDescription = json['aboutDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['favourableDirections'] = this.favourableDirections;
    data['aboutDescription'] = this.aboutDescription;
    return data;
  }
}