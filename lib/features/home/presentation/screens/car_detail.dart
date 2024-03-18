import 'package:drive_doctor/Model/car.dart';
import 'package:drive_doctor/core/services/Global.dart';
import 'package:drive_doctor/core/services/helper.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeCubit.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'add_car.dart';
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

    return SafeArea(

      child: BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);
          var carModel = homeCubit.listUserCars
              .firstWhere((element) => element.carId == selectedCarModel.carId);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.black,
            floatingActionButton:
            homeCubit.listUserCars.isNotEmpty
                ? FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) =>
                    AddService(carModel: carModel,index: index,),
                );
              },
              child:Image.asset("assets/image/service.png",height: 50,width: 50),
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
                child: Column(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        height: height * 0.21.h,
                        width: width,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          // Add this line for bounce effect
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return index == 0
                                ? testab(
                                    const Icon(Icons.car_crash,
                                        color: Colors.white),
                                    "Battery",
                                    "71%",
                                    (height / 4) / 5,
                                    "210 mi left",
                                    true,
                                    context)
                                : index == 1
                                    ? testab(
                                        const Icon(Icons.car_crash,
                                            color: Colors.white),
                                        "Mileage",
                                        "10345 mi",
                                        (height / 4) / 9,
                                        "+ 23 min today",
                                        true,
                                        context)
                                    : index == 2
                                        ? testab(
                                            const Icon(Icons.car_crash,
                                                color: Colors.white),
                                            "Temperature",
                                            "39%",
                                            (height / 4) / 5,
                                            "Choke free",
                                            true,
                                            context)
                                        : const SizedBox();
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
                ),
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget testab(Icon icons, String iconname, String details,
      double detailsheigth, String detaildata, bool see, context) {
    double height = MediaQuery.of(context).size.height / 4;
    double width = MediaQuery.of(context).size.width / 3;
    return Container(
      padding: EdgeInsets.all(height / 25),
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            15.0,
          ),
          gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(20, 20, 20, 1),
                Color.fromRGBO(34, 34, 34, 1)
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          icons,
          const SizedBox(
            height: 2.0,
          ),
          Text(
            iconname,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            details,
            style: TextStyle(fontSize: detailsheigth, color: Colors.white),
          ),
          Text(
            detaildata,
            style: const TextStyle(color: Color.fromRGBO(112, 112, 112, 1)),
          ),
          const Spacer(),
          Text(
            see == true ? "Details" : "",
            style: const TextStyle(color: Color.fromRGBO(112, 112, 112, 1)),
          ),
        ],
      ),
    );
  }

  Widget parts(String image, String product, String cost, context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: SizedBox(
        height: 100,
        width: 200,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
                right: 0.0,
                child: Container(
                    padding: EdgeInsets.only(
                        top: (height / 7) / 6,
                        left: (width / 2.2) / 5,
                        right: (width / 2.2) / 10),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(20, 20, 20, 1),
                              Color.fromRGBO(34, 34, 34, 1)
                            ],
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter),
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Tesla",
                          style: TextStyle(
                              color: Color.fromRGBO(112, 112, 112, 1)),
                        ),
                        const Text(
                          "Fast Charger",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                          height: height / 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("\$$cost",
                                style: const TextStyle(color: Colors.white)),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.car_crash,
                                  color: Colors.white,
                                  size: height / 60,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  product,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: height / 80),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ))),
            Positioned(
              top: (height / 8) / 7,
              left: -20.0,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(image), fit: BoxFit.cover)),
              ),
            ),
          ],
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
