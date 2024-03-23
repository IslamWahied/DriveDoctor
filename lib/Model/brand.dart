class BrandModel {
  int brandId;
  String brandImageUrl;
  String brandName;


  BrandModel({
    required this.brandId,
    required this.brandImageUrl,
    required this.brandName,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      brandId: json['brandId'],
      brandImageUrl: json['brandImageUrl'],
      brandName: json['brandName'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brandId': brandId,
      'brandImageUrl': brandImageUrl,
      'brandName': brandName,

    };
  }
}
