import 'package:animations/animations.dart';
import 'package:drive_doctor/core/services/Global.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeCubit.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeState.dart';
import 'package:drive_doctor/features/home/presentation/screens/user_profile.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'car.dart';

bool _isFirstBuild = true;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Run your function only when the screen is first initialized
    if (_isFirstBuild) {
      HomeCubit.get(context).getUserCarModels();
      _isFirstBuild = false;
    }
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.black,
          resizeToAvoidBottomInset: false,
          floatingActionButton: HomeCubit.get(context).listUserCars.isNotEmpty
              ? FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) =>
                          const AddCarBottomSheet(),
                    );
                  },
                  child: Image.asset("assets/image/1.png"),
                )
              : const SizedBox(),
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(25.0),
              height: height,
              width: width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Color.fromRGBO(34, 34, 34, 1)],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                            width: 50, height: 50, child: UserProfile()),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Welcome , ',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  Global.userModel.userFullName ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        const Icon(
                          Icons.notifications,
                          color: Colors.white,
                        )
                      ],
                    ),
                    SizedBox(height: 35.h),
                    if (homeCubit.listUserCars.isNotEmpty)
                      const Text(
                        "Your current cars",
                        style: TextStyle(
                            color: Color.fromRGBO(112, 112, 112, 1),
                            fontSize: 20),
                      ),
                    if (homeCubit.listUserCars.isNotEmpty)
                      SizedBox(height: 30.h),
                    Expanded(
                      child: homeCubit.listUserCars.isNotEmpty
                          ? GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 0),
                              children: List.generate(
                                  homeCubit.listUserCars.length, (index) {
                                return MyCustomWidget(index: index);
                              }),
                            )
                          : GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      const AddCarBottomSheet(),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Center(
                                      child: Text(
                                    "Add Your First Car",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Image.asset(
                                    "assets/image/1.png",
                                    height: 60,
                                    width: 60,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}

class MyCustomWidget extends StatelessWidget {
  final int index;

  const MyCustomWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (_, openContainer) {
        return BlocConsumer<HomeCubit, HomeState>(
          builder: (context, state) {
            var homeCubit = HomeCubit.get(context);
            var carModel = homeCubit.listUserCars[index];
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    0.0,
                  ),
                  gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(20, 20, 20, 1),
                        Color.fromRGBO(34, 34, 34, 1)
                      ],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${carModel.carBrandName} ${carModel.carModel}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Hero(
                          tag: index.toString(),
                          child: Image.asset("assets/image/tesla.png",
                              width: 100, height: 50)),
                      Hero(
                        tag: index.toString(),
                        child: SvgPicture.asset(
                          Global.listBrandModel[carModel.carBrandId]
                              .brandImageUrl,
                          width: 20, // Adjust the width as needed
                          height: 20, // Adjust the height as needed
                        ),
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              carModel.carKilometers.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Text(
                              "km",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {},
        );
      },
      openColor: const Color.fromRGBO(34, 34, 34, 1),
      closedElevation: 50.0,
      closedColor: Colors.black,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      // closedColor: Colors.white,
      openBuilder: (_, closeContainer) {
        return CarDetailsScreen(
          index: index,
        );
      },
    );
  }
}

class AddCarBottomSheet extends StatefulWidget {
  const AddCarBottomSheet({super.key});

  @override
  _AddCarBottomSheetState createState() => _AddCarBottomSheetState();
}

class _AddCarBottomSheetState extends State<AddCarBottomSheet> {
  @override
  void initState() {
    HomeCubit.get(context).restBottomSheetControls();
    super.initState();
  }

  GlobalKey<FormState> addCarFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: BlocConsumer<HomeCubit, HomeState>(
          builder: (context, state) {
            var homeCubit = HomeCubit.get(context);
            return Form(
              key: addCarFormKey,
              child: Container(
                color: Colors.black87,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 5, top: 5),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.blue,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Add Car",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    TextFormField(
                      controller: homeCubit.carModelController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: "Car Model",
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a car model';
                        }
                        // You can add more validation logic here if needed
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    DropdownSearch<String>(
                      popupProps: const PopupProps.dialog(

                        showSearchBox: true,
                        showSelectedItems: true,

                        dialogProps: DialogProps(

                          backgroundColor: Colors.white,
                        ),
                      ),
                      items:Global.listBrandModel.map((brand) => brand.brandName).toList(),
                      dropdownDecoratorProps: const DropDownDecoratorProps(

                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Brand Name",
                          labelStyle: TextStyle(color: Colors.grey),
                          hintText: "Select Brand Name",
                        ),
                        baseStyle: TextStyle(color: Colors.white),


                      ),

                      onChanged: print,
                      selectedItem: "Brazil",
                    ),

                    SizedBox(height: 20.h),

                    Row(
                      children: [
                        Image.asset("assets/icons/license.png",
                            width: 35, height: 35, color: Colors.white),
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (picked != null) {
                                setState(() {
                                  homeCubit.licenseFromDate = picked;
                                });
                              }
                            },
                            child: Text(
                              homeCubit.licenseFromDate == null
                                  ? 'Select License \nFrom Date'
                                  : 'From: ${DateFormat('yyyy-MM-dd').format(homeCubit.licenseFromDate!)}',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (picked != null) {
                                setState(() {
                                  homeCubit.licenseToDate = picked;
                                });
                              }
                            },
                            child: Text(
                              homeCubit.licenseToDate == null
                                  ? 'Select License \nTo Date'
                                  : 'To: ${DateFormat('yyyy-MM-dd').format(homeCubit.licenseToDate!)}',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: homeCubit.carKilometersController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Kilometers",
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select a car kilometers';
                        }
                        // You can add more validation logic here if needed
                        return null;
                      },
                    ),

                    // Add widget to select car image
                    // Add button to submit data
                    SizedBox(height: 10.h),
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
                            if (addCarFormKey.currentState!.validate()) {
                              homeCubit.addNewCar(context: context);
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

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  _UserProfileWidgetState createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: OpenContainer(
          closedBuilder: (_, openContainer) {
            return GestureDetector(
              onTap: openContainer,
              child: CircleAvatar(
                radius: 25,
                backgroundImage: Global.userModel.photoUrl != ""
                    ? NetworkImage(Global.userModel.photoUrl!)
                    : null,
                child: Global.userModel.photoUrl == ""
                    ? const Icon(Icons.person, size: 80)
                    : null,
              ),
            );
          },
          openColor: Colors.white,
          closedElevation: 50.0,
          closedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          closedColor: Colors.transparent,
          openBuilder: (_, closeContainer) {
            return const UserProfileScreen();
          },
        ),
      ),
    );
  }
}
