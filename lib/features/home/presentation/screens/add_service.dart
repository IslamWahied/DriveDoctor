import 'package:animations/animations.dart';
import 'package:drive_doctor/Model/car.dart';
import 'package:drive_doctor/core/services/Global.dart';
import 'package:drive_doctor/core/services/helper.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeCubit.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeState.dart';
import 'package:drive_doctor/features/home/presentation/screens/car_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class  AddService extends StatelessWidget {
  final int index;
  final CarModel carModel;


  const AddService({super.key, required this.index, required this.carModel});



  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (_, openContainer) {
        return BlocConsumer<HomeCubit, HomeState>(
          builder: (context, state) {


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
                        TextStyle(color: Colors.white, fontSize: 14.w),
                      ),

                      Hero(
                          tag: index.toString(),
                          child: Image.asset("assets/image/tesla.png",
                              width: 100.w, height: 40.h)),
                      if(Global.listBrandModel[carModel.carBrandId].brandImageUrl != "")
                        Hero(
                          tag: index.toString(),
                          child: SvgPicture.asset(
                            Global.listBrandModel[carModel.carBrandId].brandImageUrl,
                            width: 20.w, // Adjust the width as needed
                            height: 10.h, // Adjust the height as needed
                          ),
                        ),

                      SizedBox(height: 5.h),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              carModel.carKilometers.toString(),
                              style:   TextStyle(color: Colors.white,fontSize:15.w ),
                            ),
                            const Text(
                              "km",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text("License  (${getDaysBetween(fromDate: carModel.licenseToDate)} Days)",
                          textAlign: TextAlign.center,style:   TextStyle(
                              color:
                              getDaysBetween(fromDate: carModel.licenseToDate) >= 30?
                              Colors.green
                                  :
                              getDaysBetween(fromDate: carModel.licenseToDate) < 30 && getDaysBetween(fromDate: carModel.licenseToDate) > 0?
                              Colors.yellow
                                  :
                              getDaysBetween(fromDate: carModel.licenseToDate) <= 0?
                              Colors.red
                                  :
                              Colors.red,
                              fontSize:10.w
                          )),
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
          selectedCarModel: carModel ,
        );
      },
    );
  }
}