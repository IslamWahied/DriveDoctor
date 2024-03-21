import 'package:drive_doctor/Model/car.dart';
import 'package:drive_doctor/Model/service.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/homeCubit.dart';

class RepairServiceBottomSheet extends StatefulWidget {
  final CarModel carModel;
  final ServiceModel serviceModel;

  const RepairServiceBottomSheet({super.key, required this.carModel, required this.serviceModel});

  @override
  _RepairServiceBottomSheetState createState() =>
      _RepairServiceBottomSheetState();
}

class _RepairServiceBottomSheetState
    extends State<RepairServiceBottomSheet> {
  final _firstController = TextEditingController();
  final _secondController = TextEditingController();
  final _constController = TextEditingController();
  final _detailController = TextEditingController();
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
    _constController.dispose();
    _detailController.dispose();
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
                        labelText: "Last Repair Kilometers",
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
                        labelText: "New Repair Kilometers",
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
                    TextFormField(
                      controller: _constController,
                      keyboardType: TextInputType.number,
                      decoration:   InputDecoration(

                        suffixStyle: const TextStyle(color: Colors.white),
                        suffixIcon: Icon(Icons.monetization_on,color: Colors.grey[350]),
                        labelText: "Cost",
                        hintText: "0",
                        hintStyle:  const TextStyle(color: Colors.grey),
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a cost';
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: _detailController,

                      maxLines: 4,
                      minLines: 4,
                      decoration:   InputDecoration(
                       suffixIcon: Icon(Icons.description,color: Colors.grey[350]),
                        suffixStyle: const TextStyle(color: Colors.white),
                        labelText: "Detail",
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a detail';
                        }

                        return null;
                      },
                    ),
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
                                detail: _detailController .text,
                                cost: double.parse(_constController.text),
                                carKilometers: widget.carModel.carKilometers,
                                oldServiceKilometersMade:  widget.serviceModel.lastServiceKilometersMade   ,
                                newServiceKilometersMade: int.parse(_secondController.text) ,
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

