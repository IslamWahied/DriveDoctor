import 'package:animations/animations.dart';
import 'package:drive_doctor/Model/car.dart';
import 'package:drive_doctor/Model/service.dart';
import 'package:drive_doctor/core/services/Global.dart';
import 'package:drive_doctor/core/services/helper.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeCubit.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'add_service.dart';

class CarDetailsScreen extends StatelessWidget {
  final int index;
  final CarModel selectedCarModel;

  const CarDetailsScreen(
      {super.key, required this.index, required this.selectedCarModel});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Run your function only when the screen is first initialized

    return SafeArea(
      child: BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);
          var carModel = homeCubit.listUserCars
              .firstWhere((element) => element.carId == selectedCarModel.carId);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.black,
            floatingActionButton: homeCubit.listUserCars.isNotEmpty
                ? FloatingActionButton(
                    backgroundColor: Colors.black,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) =>
                            AddServiceBottomSheetForm(
                          carModel: carModel,
                        ),
                      );
                    },
                    child: Image.asset("assets/image/service.png",
                        height: 50, width: 50),
                  )
                : const SizedBox(),
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black, Color.fromRGBO(34, 34, 34, 1)],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter)),
              child: SingleChildScrollView(
                child: BlocConsumer<HomeCubit,HomeState>(
                  builder: (context,state){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0, left: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 5.0.h,
                                  ),
                                  Text(
                                    "${carModel.carBrandName} Model ${carModel.carModel}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height * 0.03.h),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          "License Expire  ${carModel.licenseToDate.toString()} (${getDaysBetween(fromDate: carModel.licenseToDate)} Days)",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: getDaysBetween(
                                                  fromDate: carModel
                                                      .licenseToDate) >=
                                                  30
                                                  ? Colors.green
                                                  : getDaysBetween(
                                                  fromDate: carModel
                                                      .licenseToDate) <
                                                  30 &&
                                                  getDaysBetween(
                                                      fromDate: carModel
                                                          .licenseToDate) >
                                                      0
                                                  ? Colors.yellow
                                                  : getDaysBetween(
                                                  fromDate: carModel
                                                      .licenseToDate) <=
                                                  0
                                                  ? Colors.red
                                                  : Colors.red)),
                                      IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return UpdateLicenseDateBottomSheet(
                                                    carModel: carModel);
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 20,
                                          ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${carModel.carKilometers.toString()} ",
                                            style: TextStyle(fontSize: 20.h),
                                            textAlign: TextAlign.center,
                                          ),
                                          const Text(
                                            "KM",
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return UpdateKilometersBottomSheet(
                                                    carModel: carModel);
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 20,
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                ],
                              ),

                              Hero(
                                tag: index.toString(),
                                child: Global.listBrandModel
                                    .firstWhere((element) =>
                                element.brandId ==
                                    carModel.carBrandId)
                                    .brandImageUrl ==
                                    ""
                                    ? const SizedBox()
                                    : Image.network(
                                  Global.listBrandModel
                                      .firstWhere((element) =>
                                  element.brandId ==
                                      carModel.carBrandId)
                                      .brandImageUrl,
                                  width: 50.w, // Adjust the width as needed
                                  height: 50.h,
                                  // Adjust the height as needed
                                ),
                              ),

                              // Icon(
                              //   Icons.search,
                              //   color: Colors.white,
                              //   size: height / 25,
                              // )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                          child: Hero(
                            tag: index.toString(),
                            child: Container(
                              height: height * 0.23.h,
                              width: width,
                              decoration: const BoxDecoration(
                                // color: Colors.red,
                                  image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                        Colors.white, // Apply red color filter
                                        BlendMode.modulate,
                                      ),
                                      image: AssetImage("assets/image/tesla.png"),
                                      fit: BoxFit.contain)),
                            ),
                          ),
                        ),
                        SizedBox(height: 25.h,),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 10.w),
                          child: SizedBox(
                            height: height * 0.21.h,
                            width: width,
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              // Add this line for bounce effect
                              scrollDirection: Axis.horizontal,
                              itemCount: homeCubit.listCarServices.length,
                              itemBuilder: (context, index) {
                                var model = homeCubit.listCarServices[index];
                                var servicePercentage =
                                getPercentageDifference(lastServiceKilometersMade: model.lastServiceKilometersMade, serviceKilometers: model.serviceKilometers, currentCarKilometers: carModel.carKilometers).toString();

                                var getDifferenceBetweenKilometers =
                                getDifferenceBetweenTwoNumbers(
                                    firstNumber: carModel.carKilometers,
                                    secondNumber:
                                    model.lastServiceKilometersMade);

                                return serviceTab(
                                    serviceModel: model,
                                    carModel: selectedCarModel,
                                    icons: Image.asset(
                                      "assets/image/repair.png",
                                      height: 20,
                                      width: 20,
                                      color:servicePercentage == "100"?Colors.white : Colors.white,
                                    ),
                                    serviceName: model.serviceName,
                                    servicePercentage: servicePercentage,
                                    detailsHeigth: 30.h,
                                    detaildata:
                                    "$getDifferenceBetweenKilometers km Over",
                                    see: true,
                                   );
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 15.w),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: height / 30,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 25.0),
                        //   child: Text(
                        //     "Suggested Ports",
                        //     style: TextStyle(
                        //         color: const Color.fromRGBO(115, 115, 115, 1),
                        //         fontSize: height / 50),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: height / 30,
                        // ),
                        // SizedBox(
                        //   height: height / 7,
                        //   width: width,
                        //   child: ListView(
                        //     scrollDirection: Axis.horizontal,
                        //     children: <Widget>[
                        //       parts("assets/image/charger.png", "Fast Charger",
                        //           "499", context),
                        //       parts(
                        //           "assets/image/tires.png", "Tires", "199", context)
                        //     ],
                        //   ),
                        // )
                      ],
                    );
                  },
                  listener: (context,state){

                  },

                ),
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }

}

class serviceTab extends StatelessWidget {
     Image icons;

      CarModel carModel;
     ServiceModel serviceModel;
     String serviceName;
     String servicePercentage;
     double detailsHeigth;
     String detaildata;
     bool see;
    serviceTab({super.key, required this.icons, required this.carModel, required this.serviceModel, required this.serviceName, required this.servicePercentage, required this.detailsHeigth, required this.detaildata, required this.see});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height.h / 4;
    double width = MediaQuery.of(context).size.width.w / 3;
    return OpenContainer(

      openColor: const Color.fromRGBO(34, 34, 34, 1),
      closedElevation: 50.0,
      closedColor: Colors.transparent,
      closedBuilder: (_, openContainer) {

        return Container(
          padding: EdgeInsets.all(height.h / 25),
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                15.0,
              ),
              gradient: LinearGradient(
                  colors: [
                    servicePercentage == "100"?Colors.red[500]!  :  const Color.fromRGBO(20, 20, 20, 1),
                    servicePercentage == "100"?Colors.red[100]!  :    const Color.fromRGBO(34, 34, 34, 1)
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              icons,
              Column(
                children: [
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    serviceName,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),

              Text(
                "$servicePercentage %",
                style: TextStyle(fontSize: detailsHeigth, color: Colors.white),
              ),
              Text(
                detaildata,
                style:   TextStyle(
                    fontWeight:servicePercentage == "100"? FontWeight.w500 : FontWeight.w500,
                    color: servicePercentage == "100"?Colors.black : const Color.fromRGBO(112, 112, 112, 1)),
              ),
              if(servicePercentage == "100")
                const Text(
                  "Expired",
                  style:   TextStyle(
                      fontSize: 18,
                      fontWeight:  FontWeight.w800,
                      color:   Colors.red),
                ),
              Text(
                see == true ? "Details" : "",
                style:  TextStyle(
                    fontWeight:servicePercentage == "100"? FontWeight.w500 : FontWeight.w500
                    ,color: servicePercentage == "100"?Colors.black : const Color.fromRGBO(112, 112, 112, 1)),
              ),
            ],
          ),
        );
      },
      onClosed: (never){
        Future.delayed(const Duration(milliseconds: 500), () {
          // printed = false; // Update the flag to true after printing

        });

      },
      openBuilder: (_, closeContainer) {
        // if (!printed) {
        //   HomeCubit.get(context).getCarServices(context: context, carId: carModel.carId).catchError((onError){});
        //
        //   printed = true; // Update the flag to true after printing
        // }

        return      ServiceScreen(
          icons: icons,
          carModel:carModel,


          detailsHeigth:detailsHeigth ,

          serviceModel: serviceModel,
          serviceName: serviceName,


        );
      },
    );
  }
}




class ServiceScreen extends StatelessWidget {

  final  Image icons;
  final  String serviceName;

  final  double detailsHeigth;

  final  CarModel carModel;
     ServiceModel serviceModel;



    ServiceScreen({
   super.key, required this.icons, required this.serviceName, required this.detailsHeigth , required this.carModel, required this.serviceModel});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height.h;
    double width = MediaQuery.of(context).size.width.w;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text("Services Detail",style: TextStyle(fontSize: 15.h,color: Colors.white),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: const Color(0xFF212121),
      resizeToAvoidBottomInset: false,

      body: BlocConsumer<HomeCubit,HomeState>(
        builder: (context,state){

          var homeCubit = HomeCubit.get(context);
          var lisServiceModel = homeCubit.listCarServices.firstWhere((element) =>
          element.serviceId == serviceModel.serviceId &&
          element.carId == serviceModel.carId

          );
          var servicePercentage =
          getPercentageDifference(lastServiceKilometersMade: lisServiceModel.lastServiceKilometersMade, serviceKilometers: lisServiceModel.serviceKilometers, currentCarKilometers: carModel.carKilometers).toString();

          var getDifferenceBetweenKilometers =
          getDifferenceBetweenTwoNumbers(
              firstNumber: carModel.carKilometers,
              secondNumber:
              lisServiceModel.lastServiceKilometersMade);

          return  Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Color.fromRGBO(34, 34, 34, 1)],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              serviceName,
                              style: TextStyle(color: Colors.white,fontSize: 30),
                            ),
                            SizedBox(width: 10.w),
                            Image.asset(
                              "assets/image/repair.png",
                              height: 30,
                              width: 30,
                              color:servicePercentage == "100"?Colors.white : Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h,),

                          Text(
                            servicePercentage == "100"?  "Expired" : "Valid",
                            style:   TextStyle(
                                fontSize: 18.h,
                                fontWeight:  FontWeight.w800,
                                color:  servicePercentage == "100"?Colors.red : Colors.green),
                          ),

                          SizedBox(height: 5.h,),

                          Text(
                            servicePercentage == "100"?"$getDifferenceBetweenKilometers km Over" :
                            "$getDifferenceBetweenKilometers km"
                            ,
                            style:   TextStyle(
                                fontWeight:servicePercentage == "100"? FontWeight.w500 : FontWeight.w500,
                                color: servicePercentage == "100"?Colors.red :  Colors.blue),
                          ),

                          SizedBox(height: 5.h,),

                          Text(
                            "$servicePercentage %",
                            style: TextStyle(fontSize: 17.h, color: servicePercentage == "100"?Colors.redAccent :  Colors.blue),
                          ),


                        SizedBox(height: 10.h,),

                        Text(
                          "Service should repair every ${lisServiceModel.serviceKilometers} km",
                          style: TextStyle(fontSize: 14.w, color: Colors.yellow),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    Row(

                      children: [
                        Text(
                            "${carModel.carBrandName} Model ${carModel.carModel}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color:  Colors.white,fontSize: 16.h)),
                        SizedBox(width: 10.w,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${carModel.carKilometers.toString()} ",
                              style: TextStyle(fontSize: 16.h,color: Colors.green),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              "KM",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Last Repair    ${lisServiceModel.lastServiceKilometersMade.toString()}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14.h,
                                  color: getDaysBetween(
                                      fromDate: carModel
                                          .licenseToDate) >=
                                      30
                                      ? Colors.green
                                      : getDaysBetween(
                                      fromDate: carModel
                                          .licenseToDate) <
                                      30 &&
                                      getDaysBetween(
                                          fromDate: carModel
                                              .licenseToDate) >
                                          0
                                      ? Colors.yellow
                                      : getDaysBetween(
                                      fromDate: carModel
                                          .licenseToDate) <=
                                      0
                                      ? Colors.red
                                      : Colors.red),


                            ),
                            SizedBox(width: 5.w,),
                            const Text(
                              "KM",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.yellow),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return UpdateServiceKilometersBottomSheet(
                                      serviceModel: lisServiceModel,
                                      carModel: carModel);
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ))
                      ],
                    ),






                  ],
                ),
              ),
            ),
          );
        },
      listener: (context,state){},
      ),
    );
  }
}




class UpdateServiceKilometersBottomSheet extends StatefulWidget {
  final CarModel carModel;
  final ServiceModel serviceModel;

  const UpdateServiceKilometersBottomSheet({super.key, required this.carModel, required this.serviceModel});

  @override
  _UpdateServiceKilometersBottomSheetState createState() =>
      _UpdateServiceKilometersBottomSheetState();
}

class _UpdateServiceKilometersBottomSheetState
    extends State<UpdateServiceKilometersBottomSheet> {
  final _firstController = TextEditingController();
  final _secondController = TextEditingController();
  GlobalKey<FormState> updateKilometersFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _firstController.text = widget.serviceModel.lastServiceKilometersMade.toString();
    super.initState();
  }

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: BlocConsumer<HomeCubit, HomeState>(
          builder: (context, state) {
            var homeCubit = HomeCubit.get(context);
            return Form(
              key: updateKilometersFormKey,
              child: Container(
                color: Colors.black87,
                padding: EdgeInsets.all(16.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _firstController,
                      readOnly: true,
                      style: TextStyle(color: Colors.grey[500]),
                      decoration: InputDecoration(
                        suffixText: "KM",
                        suffixStyle: TextStyle(color: Colors.grey[500]),
                        labelText: "Old Kilometers",
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: _secondController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        suffixText: "KM",
                        suffixStyle: TextStyle(color: Colors.white),
                        labelText: "New Kilometers",
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a number';
                        }
                        final firstValue = int.tryParse(_firstController.text);
                        final secondValue = int.tryParse(value);
                        if (firstValue != null && secondValue != null) {
                          if (secondValue <= 0) {
                            return 'Value must be greater than 0';
                          }
                          if (secondValue > widget.carModel.carKilometers) {
                            return 'Value must be smaller Or equal car km than 0';
                          }
                          if (secondValue <= firstValue) {
                            return 'Value must be greater than the first field';
                          }
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "Close",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        SizedBox(width: 10.h),
                        ElevatedButton(
                          onPressed: () {

                            if (updateKilometersFormKey.currentState!.validate()) {
                              homeCubit.updateServiceKilometers(
                                  context: context,
                                  newServiceKilometers:int.parse(_secondController.text) ,
                                  serviceId:widget.serviceModel.serviceId ,
                                  carId: widget.carModel.carId.toString(),
                                  );
                            }
                          },
                          child: const Text("Submit"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}





class UpdateKilometersBottomSheet extends StatefulWidget {
  final CarModel carModel;

  const UpdateKilometersBottomSheet({super.key, required this.carModel});

  @override
  _UpdateKilometersBottomSheetState createState() =>
      _UpdateKilometersBottomSheetState();
}

class _UpdateKilometersBottomSheetState
    extends State<UpdateKilometersBottomSheet> {
  final _firstController = TextEditingController();
  final _secondController = TextEditingController();
  GlobalKey<FormState> updateKilometersFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _firstController.text = widget.carModel.carKilometers.toString();
    super.initState();
  }

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: updateKilometersFormKey,
      child: BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);
          return Container(
            color: Colors.black87,
            padding: EdgeInsets.all(16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _firstController,
                  readOnly: true,
                  style: TextStyle(color: Colors.grey[500]),
                  decoration: InputDecoration(
                    suffixText: "KM",
                    suffixStyle: TextStyle(color: Colors.grey[500]),
                    labelText: "Old Kilometers",
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  controller: _secondController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    suffixText: "KM",
                    suffixStyle: TextStyle(color: Colors.white),
                    labelText: "New Kilometers",
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    final firstValue = int.tryParse(_firstController.text);
                    final secondValue = int.tryParse(value);
                    if (firstValue != null && secondValue != null) {
                      if (secondValue <= 0) {
                        return 'Value must be greater than 0';
                      }
                      if (secondValue <= firstValue) {
                        return 'Value must be greater than the first field';
                      }
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Close",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    SizedBox(width: 10.h),
                    ElevatedButton(
                      onPressed: () {
                        // if(homeCubit.licenseFromDate == null || homeCubit.licenseToDate == null){
                        //   setState(() {
                        //     homeCubit.isLicenseDateValid = false;
                        //   });
                        // }
                        // else if(!homeCubit.isDateInRange(startDate:homeCubit.licenseFromDate,
                        //     endDate:homeCubit.licenseToDate!)){
                        //   setState(() {
                        //     homeCubit.isLicenseDateValid = false;
                        //   });
                        // }
                        //
                        if (updateKilometersFormKey.currentState!.validate()) {
                          homeCubit.updateCarKilometers(
                              context: context,
                              carId: widget.carModel.carId.toString(),
                              newKilometers: int.parse(_secondController.text));
                        }
                      },
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}

class UpdateLicenseDateBottomSheet extends StatefulWidget {
  final CarModel carModel;

  const UpdateLicenseDateBottomSheet({super.key, required this.carModel});

  @override
  _UpdateLicenseDateBottomSheetState createState() =>
      _UpdateLicenseDateBottomSheetState();
}

class _UpdateLicenseDateBottomSheetState
    extends State<UpdateLicenseDateBottomSheet> {
  final _firstController = TextEditingController();
  final _secondController = TextEditingController();
  GlobalKey<FormState> updateLicenseDateFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: updateLicenseDateFormKey,
      child: BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);
          return Container(
            color: Colors.black87,
            padding: EdgeInsets.all(16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _firstController,
                  readOnly: true,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null) {
                      setState(() {
                        var fromDate =
                            DateFormat('yyyy-MM-dd').format(picked!).toString();
                        _firstController.text = fromDate;
                      });
                    }
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.calendar_month),
                    labelText: "License From Date",
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      : 'Please enter a license from date ',
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  controller: _secondController,
                  readOnly: true,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null) {
                      setState(() {
                        var toDate =
                            DateFormat('yyyy-MM-dd').format(picked!).toString();
                        _secondController.text = toDate;
                      });
                    }
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.calendar_month),
                    labelText: "License To Date",
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      : 'Please enter a license to date ',
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Close",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    SizedBox(width: 10.h),
                    ElevatedButton(
                      onPressed: () {
                        if (updateLicenseDateFormKey.currentState!.validate()) {
                          homeCubit.updateCarLicenseDate(
                            context: context,
                            currentDate: widget.carModel.licenseToDate,
                            fromDate: _firstController.text,
                            toDate: _secondController.text,
                            carId: widget.carModel.carId.toString(),
                          );
                        }
                      },
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
