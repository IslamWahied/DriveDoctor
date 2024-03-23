class ServiceModel {

  String userId;
  String serviceId;
  String carId;
  String serviceName;
  String createdDate;
  int  serviceKilometers;
  int  lastServiceKilometersMade;

  ServiceModel({
    required this.userId,
    required this.serviceId,
    required this.carId,
    required this.serviceName,
    required this.createdDate,
    required this.serviceKilometers,
    required this.lastServiceKilometersMade,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      userId: json['userId'],
      serviceId: json['serviceId'],
      carId: json['carId'],
      serviceName: json['serviceName'],
      createdDate: json['createdDate'],
      serviceKilometers: json['serviceKilometers'],
      lastServiceKilometersMade: json['lastServiceKilometersMade'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'serviceId': serviceId,
      'carId': carId,
      'serviceName': serviceName,
      'createdDate': createdDate,
      'serviceKilometers': serviceKilometers,
      'lastServiceKilometersMade': lastServiceKilometersMade,

    };
  }
}
