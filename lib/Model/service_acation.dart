class ServiceHistoryModel {

  String userId;
  String serviceId;
  String serviceHistoryId;
  String carId;
  String createdDate;
  int  carKilometers;
  int  oldServiceKilometersMade;
  int  newServiceKilometersMade;
  double cost;
  String detail;

  ServiceHistoryModel({
    required this.userId,
    required this.serviceId,
    required this.serviceHistoryId,
    required this.carId,
    required this.createdDate,
    required this.carKilometers,
    required this.oldServiceKilometersMade,
    required this.newServiceKilometersMade,
    required this.cost,

    required this.detail,

  });

  factory ServiceHistoryModel.fromJson(Map<String, dynamic> json) {
    return ServiceHistoryModel(
      userId: json['userId'],
      serviceId: json['serviceId'],
      serviceHistoryId: json['serviceHistoryId'],
      carId: json['carId'],
      createdDate: json['createdDate'],
      carKilometers: json['carKilometers'],
      oldServiceKilometersMade: json['oldServiceKilometersMade'],
      newServiceKilometersMade: json['newServiceKilometersMade'],
      cost: json['cost'],
      detail: json['detail'],


    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'serviceId': serviceId,
      'serviceHistoryId': serviceHistoryId,
      'carId': carId,
      'createdDate': createdDate,
      'carKilometers': carKilometers,
      'oldServiceKilometersMade': oldServiceKilometersMade,
      'newServiceKilometersMade': newServiceKilometersMade,
      'cost': cost,
      'detail': detail,
    };
  }
}
