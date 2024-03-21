import 'package:drive_doctor/Model/car.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeCubit.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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