class CarModel {

  String carModel;
  String carColor;
  int carBrandId;
  String carBrandName;
  String licenseFromDate;
  String licenseToDate;
  int carKilometers;


  CarModel({

    required this.carColor,
    required this.carModel,
    required this.carBrandId,
    required this.carBrandName,
    required this.licenseFromDate,
    required this.licenseToDate,
    required this.carKilometers,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(

      carColor: json['carColor'],
      carModel: json['carModel'],
      carBrandId: json['carBrandId'],
      carBrandName: json['carBrandName'],
      licenseFromDate: json['licenseFromDate'],
      licenseToDate: json['licenseToDate'],
      carKilometers: json['carKilometers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {

      'carColor': carColor,
      'carModel': carModel,
      'carBrandId': carBrandId,
      'carBrandName': carBrandName,
      'licenseFromDate': licenseFromDate,
      'licenseToDate': licenseToDate,
      'carKilometers': carKilometers,
    };
  }
}
