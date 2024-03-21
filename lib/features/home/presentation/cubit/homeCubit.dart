import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_doctor/Model/brand.dart';
import 'package:drive_doctor/Model/car.dart';
import 'package:drive_doctor/Model/service.dart';
import 'package:drive_doctor/Model/service_acation.dart';
import 'package:drive_doctor/Model/user.dart';
import 'package:drive_doctor/core/services/Global.dart';
import 'package:drive_doctor/core/services/StringManager.dart';
import 'package:drive_doctor/core/services/shared_helper.dart';
import 'package:drive_doctor/features/home/presentation/screens/service/service_screen.dart';
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
  BrandModel? selectedCarBrandModel;



  restBottomSheetControls() {
    isLicenseDateValid = true;
    carModelController.text = "";
    carKilometersController.text = "";
    selectedCarBrandModel = null;
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
  bool isDateInRange({required DateTime? startDate, required DateTime? endDate}) {

if(startDate != null && endDate != null){
  return endDate.isAfter(startDate) && startDate.isBefore(endDate);
}
else{
  return false;
}

  }
bool  isLicenseDateValid = true;
  Future<void> addNewCar({required BuildContext context}) async {
    if (licenseFromDate == null || licenseToDate == null) {
      isLicenseDateValid = false;
      return;
    } else if (!isDateInRange(startDate: licenseFromDate!, endDate: licenseToDate!)) {
      isLicenseDateValid = false;
      return;
    } else {
      var toDate = DateFormat('yyyy-MM-dd').format(licenseToDate!).toString();
      var fromDate = DateFormat('yyyy-MM-dd').format(licenseFromDate!).toString();
      CarModel carModel = CarModel(
        // Do not set carId here, it will be set after adding to Firestore
        carBrandId: selectedCarBrandModel?.brandId ?? 0,
        carBrandName: selectedCarBrandModel?.brandName ?? "",
        carColor: "",
        carKilometers: int.parse(carKilometersController.text),
        carModel: carModelController.text,
        licenseFromDate: fromDate,
        licenseToDate: toDate, carId: '',
      );
      try {
        Navigator.of(context).pop();
        DocumentReference docRef = await FirebaseFirestore.instance
            .collection('UserCars')
            .doc(Global.userModel.uid)
            .collection('CarModel')
            .add(carModel.toJson());

        // Get the ID generated by Firebase and set it back to the carModel object
        String carId = docRef.id;
        carModel.carId = carId;
        // Now, update the document in Firestore to set the carId
        await docRef.update({'carId': carId});
        print('Car model added successfully with ID: $carId');
      } catch (e) {
        print('Error adding car model: $e');
      }

      // getUserCarModels();
    }

    emit(AddNewCarState());
  }











  Future<void> addCarService(
      {
        required BuildContext context,
        required CarModel carModel,
        required String serviceName,
        required serviceKilometers,
        required lastServiceKilometersMade,

      }
      ) async {


    ServiceModel serviceModel = ServiceModel(
        carId: carModel.carId,
        userId: Global.userModel.uid!,
        serviceKilometers:serviceKilometers ,
        lastServiceKilometersMade: lastServiceKilometersMade,
        serviceName: serviceName,
        createdDate: DateTime.now().toString(),
        serviceId: ""
    );
    try {
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('UserCars')
          .doc(Global.userModel.uid)
          .collection('CarModel')
          .doc(serviceModel.carId)
          .collection('CarServices')
          .add(serviceModel.toJson());

      // Get the ID generated by Firebase and set it back to the carModel object
      String serviceId = docRef.id;
      serviceModel.serviceId = serviceId;
      // Now, update the document in Firestore to set the carId
      await docRef.update({'serviceId': serviceId});
      print('Service added successfully with ID: $serviceId');
    } catch (e) {
      print('Error adding car model: $e');
    }

    Navigator.of(context).pop();
     getCarServices(context: context,carId:carModel.carId);

    emit(AddNewCarState());
  }


  List<ServiceModel> listCarServices = [];
  Future<List<ServiceModel>> getCarServices({
    required BuildContext context,
    required String carId,
  }) async {


    listCarServices = [];
    try {
         FirebaseFirestore.instance
          .collection('UserCars')
          .doc(Global.userModel.uid)
          .collection('CarModel')
          .doc(carId)
          .collection('CarServices')
          .snapshots().listen((snapshot) {
           listCarServices = snapshot.docs
               .map((doc) => ServiceModel.fromJson(doc.data()))
               .toList();

           emit(AddNewCarState());
      });



      return listCarServices;
    } catch (e) {
      print('Error getting car services: $e');
      return [];
    }
  }



  List<ServiceHistoryModel> listServiceHistoryModel = [];
  Future<List<ServiceHistoryModel>> getServiceHistory({
    required BuildContext context,
    required String carId,
    required String serviceId,


  }) async {


    listServiceHistoryModel = [];
    try {
      FirebaseFirestore.instance
          .collection('UserCars')
          .doc(Global.userModel.uid)
          .collection('CarModel')
          .doc(carId)
          .collection('CarServices')
          .doc(serviceId)
    .collection("ServicesHistory")
          .snapshots().listen((snapshot) {
        listServiceHistoryModel = snapshot.docs
            .map((doc) => ServiceHistoryModel.fromJson(doc.data()))
            .toList();

        emit(AddNewCarState());
      });



      return listServiceHistoryModel;
    } catch (e) {
      print('Error getting car services: $e');
      return [];
    }
  }





  List<CarModel> listUserCars = [];


  Future<void> updateCarKilometers({
    required BuildContext context,

    required String carId,
    required int newKilometers,
  }) async {
    try {

      // Reference to the document representing the specific car
      DocumentReference carRef = FirebaseFirestore.instance
          .collection('UserCars')
          .doc(Global.userModel.uid)
          .collection('CarModel')
          .doc(carId);

      // Update the document with the new carKilometers value
      await carRef.update({'carKilometers': newKilometers});
      Navigator.of(context).pop();
      print('Car kilometers updated successfully.');
    } catch (e) {
      print('Error updating car kilometers: $e');
    }


    // Optionally, you may want to refresh the UI or perform any other actions here.
  }

  Future<void> updateServiceKilometers({
    required BuildContext context,
    required String carId,
    required String serviceId,
    required String detail,
    required int carKilometers,
    required int oldServiceKilometersMade,
    required int newServiceKilometersMade,
    required double cost,
  }) async {
    try {

      // Reference to the document representing the specific car
      DocumentReference carRef = FirebaseFirestore.instance
          .collection('UserCars')
          .doc(Global.userModel.uid)
          .collection('CarModel')
          .doc(carId)
      .collection('CarServices')
      .doc(serviceId);

      // Update the document with the new carKilometers value
      await carRef.update({'lastServiceKilometersMade': newServiceKilometersMade});

      ServiceHistoryModel serviceHistoryModel = ServiceHistoryModel(
          carId: carId,
          userId: Global.userModel.uid!,
          detail:detail ,
          cost:cost ,
          serviceHistoryId: "",
          carKilometers: carKilometers,
          oldServiceKilometersMade: oldServiceKilometersMade,
          newServiceKilometersMade: newServiceKilometersMade,
          createdDate: DateTime.now().toString(),
          serviceId: serviceId
      );
      try {
        DocumentReference docRef = await FirebaseFirestore.instance
            .collection('UserCars')
            .doc(Global.userModel.uid)
            .collection('CarModel')
            .doc(carId)
            .collection('CarServices')
            .doc(serviceId)
            .collection('ServicesHistory')
            .add(serviceHistoryModel.toJson());

        // Get the ID generated by Firebase and set it back to the carModel object
        String serviceHistoryId = docRef.id;
        serviceHistoryModel.serviceId = serviceHistoryId;
        // Now, update the document in Firestore to set the carId
        await docRef.update({'serviceHistoryId': serviceHistoryId});
      }catch(e){

        print(e);
      }







      Navigator.of(context).pop();

      getCarServices(context: context, carId: carId);
      print('Car Service kilometers updated successfully.');
    } catch (e) {
      print('Error updating Service car kilometers: $e');
    }


    // Optionally, you may want to refresh the UI or perform any other actions here.
  }




  Future<void> updateCarLicenseDate({
    required BuildContext context,
    required String currentDate,
    required String fromDate,
    required String toDate,
    required String carId,

  }) async {
    try {

      // Reference to the document representing the specific car
      DocumentReference carRef = FirebaseFirestore.instance
          .collection('UserCars')
          .doc(Global.userModel.uid)
          .collection('CarModel')
          .doc(carId);

      // Update the document with the new carKilometers value
      await carRef.update({'licenseFromDate': fromDate});
      await carRef.update({'licenseToDate': toDate});

      Navigator.of(context).pop();
      print('Car LicenseDate updated successfully.');
    } catch (e) {
      print('Error updating car LicenseDate: $e');
    }


    // Optionally, you may want to refresh the UI or perform any other actions here.
  }


  logOut({required BuildContext context}){
      CashHelper.clearSharedPreferences();
      CashHelper.setData(key: StringManager.isUserLogin, value: false);
      CashHelper.setData(key: StringManager.isShowWelcomeScreen, value: true);
      listUserCars = [];
      Global.fireBaseToken = "";

      Global.userModel = UserModel() ;

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ),
              (Route<dynamic> route) => false);
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