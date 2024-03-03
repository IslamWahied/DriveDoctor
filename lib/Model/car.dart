class CarModel {
  String carName;
  String carModel;
  int carBrandId;
  String licenseFromDate;
  String licenseToDate;
  int carKilometers;

  CarModel({
    required this.carName,
    required this.carModel,
    required this.carBrandId,
    required this.licenseFromDate,
    required this.licenseToDate,
    required this.carKilometers,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      carName: json['carName'],
      carModel: json['carModel'],
      carBrandId: json['carBrandId'],
      licenseFromDate: json['licenseFromDate'],
      licenseToDate: json['licenseToDate'],
      carKilometers: json['carKilometers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carName': carName,
      'carModel': carModel,
      'carBrandId': carBrandId,
      'licenseFromDate': licenseFromDate,
      'licenseToDate': licenseToDate,
      'carKilometers': carKilometers,
    };
  }
}
