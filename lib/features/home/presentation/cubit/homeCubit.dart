import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_doctor/Model/brand.dart';
import 'package:drive_doctor/Model/car.dart';
import 'package:drive_doctor/core/services/Global.dart';
import 'package:drive_doctor/core/services/StringManager.dart';
import 'package:drive_doctor/core/services/shared_helper.dart';
import 'package:drive_doctor/features/login/presentation/screens/sign_in/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'homeState.dart';
import 'package:intl/intl.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);


  final TextEditingController carModelController = TextEditingController();
  final TextEditingController carKilometersController = TextEditingController();
  DateTime? licenseFromDate;
  DateTime? licenseToDate;
  BrandModel? selectedCarBrandName;
  int? selectedCarBrandId;
  final List<String> carBrands = [
    "BMW",
    "Acura",
    "Bentley",
    "Ferrari",
    "Ford",
    "GMC",
    "Hyundai",
    "Lexus",
    "Mazda",
    "Mini"
  ];

  restBottomSheetControls() {

    carModelController.text = "";
    carKilometersController.text = "";
    selectedCarBrandName = null;
    selectedCarBrandId = 0;
    licenseFromDate = null;
    licenseToDate = null;
  }
  Future<void> getUserCarModels() async {
    try {
      // Set up a listener to receive real-time updates
      FirebaseFirestore.instance
          .collection('UserCars')
          .doc(Global.userModel.uid)
          .collection('CarModel')
          .snapshots()
          .listen((QuerySnapshot snapshot) {
        listUserCars = snapshot.docs
            .map((doc) => CarModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        emit(StartGetUserCarsState());
      });
    } catch (e) {
      print('Error getting user car models: $e');
    }
  }
  Future<void> getBrandsModels() async {
    try {
      // Set up a listener to receive real-time updates
      FirebaseFirestore.instance
          .collection('CarBrands')
          .snapshots()
          .listen((QuerySnapshot snapshot) {
      Global.listBrandModel  = snapshot.docs
            .map((doc) => BrandModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        emit(StartGetUserCarsState());
      });
    } catch (e) {
      print('Error getting user car models: $e');
    }
  }
  Future<void> addNewCar({required BuildContext context}) async {
    var toData = DateFormat('yyyy-MM-dd').format(licenseToDate!).toString();
    var fromData = DateFormat('yyyy-MM-dd').format(licenseFromDate!).toString();
    CarModel carModel = CarModel(
      carBrandId: selectedCarBrandId ?? 0,
      carBrandName: selectedCarBrandName?.brandName ?? "",
      carColor: "",
      carKilometers: int.parse(carKilometersController.text),
      carModel: carModelController.text,

      licenseFromDate: fromData,
      licenseToDate: toData,
    );
    try {
      await FirebaseFirestore.instance
          .collection('UserCars')
          .doc(Global.userModel.uid)
          .collection('CarModel')
          .add(carModel.toJson());
      print('Car model added successfully.');
    } catch (e) {
      print('Error adding car model: $e');
    }
    Navigator.of(context).pop();
    getUserCarModels();
  }

  List<CarModel> listUserCars = [];




  logOut({required BuildContext context}){

      CashHelper.setData(key: StringManager.isShowWelcomeScreen, value: true);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>const SignInScreen()),
            (Route<dynamic> route) => false,
      );


    }

  Future<void> userDeleteAccount({required BuildContext context})async{
    deleteUserAccount();
    deleteUserModel();
    deleteAllUserCarModels();
    logOut(context: context);
  }

  Future<void> deleteUserAccount() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
        print('User account deleted successfully.');
      } else {
        print('No user signed in.');
      }
    } catch (e) {
      print('Error deleting user account: $e');
    }
  }

  Future<void> deleteUserModel() async {
    try {
      // Get a reference to the UserCars collection
      CollectionReference userCarsCollection = FirebaseFirestore.instance
          .collection('users');

      // Query for documents with the given userId
      QuerySnapshot userCarsQuery = await userCarsCollection.where(
          'uid', isEqualTo: Global.userModel.uid).get();

      // Delete each document found
      userCarsQuery.docs.forEach((doc) async {
        await doc.reference.delete();
      });

      print('User data deleted successfully.');
    } catch (e) {
      print('Error deleting user data: $e');
    }
  }

  Future<void> deleteAllUserCarModels(   ) async {
    try {
      // Get a reference to the user's CarModel collection
      CollectionReference carModelsCollection = FirebaseFirestore.instance
          .collection('UserCars')
          .doc(Global.userModel.uid) // Document ID is the user ID
          .collection('CarModel');

      // Query for all documents in the CarModel collection
      QuerySnapshot carModelsQuery = await carModelsCollection.get();

      // Delete each document found
      carModelsQuery.docs.forEach((doc) async {
        await doc.reference.delete();
      });

      print('All user car models deleted successfully.');
    } catch (e) {
      print('Error deleting user car models: $e');
    }
  }



  List<BrandModel> generateBrandModels(List<String> brandNames) {
    List<BrandModel> brandModels = [];

    for (int i = 0; i < brandNames.length; i++) {
      String brandName = brandNames[i];
      // You can set a unique brandId based on the index
      // You can also set brandImageUrl based on the brand name if needed
      brandModels.add(BrandModel(
        brandId: i + 1,
        brandImageUrl: '', // Set image URL here if available
        brandName: brandName,
      ));
    }

    return brandModels;
  }

  Future<void> uploadBrands() async {
    List<String> brandNames = [
      "Acuraa", "Alfa-Romeo", "Aston Martin", "Audi", "BMW", "Bentley", "Buick", "Cadilac",
      "Chevrolet", "Chrysler", "Daewoo", "Daihatsu", "Dodge", "Eagle", "Ferrari", "Fiat",
      "Fisker", "Ford", "Freighliner", "GMC - General Motors Company", "Genesis", "Geo", "Honda",
      "Hummer", "Hyundai", "Infinity", "Isuzu", "Jaguar", "Jeep", "Kla", "Lamborghini", "Land Rover",
      "Lexus", "Lincoln", "Lotus", "Mazda", "Maserati", "Maybach", "McLaren", "Mercedez-Benz",
      "Mercury", "Mini", "Mitsubishi", "Nissan", "Oldsmobile", "Panoz", "Plymouth", "Polestar",
      "Pontiac", "Porsche", "Ram", "Rivian", "Rolls_Royce", "Saab", "Saturn", "Smart", "Subaru",
      "Susuki", "Tesla", "Toyota", "Volkswagen", "Volvo"
    ];

    List<BrandModel> brandModels = generateBrandModels(brandNames);

    final CollectionReference brandsCollection = FirebaseFirestore.instance.collection('CarBrands');

    // Loop through the BrandModel list and upload each brand to Firestore
    for (BrandModel brand in brandModels) {
      await brandsCollection.doc(brand.brandId.toString()).set(brand.toJson());
    }

    print('Brands uploaded successfully!');
  }
}