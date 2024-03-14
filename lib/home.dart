import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'car.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) => AddCarBottomSheet(),
          );

        },
        child: Image.asset("assets/image/1.png"),
      ),
      body: Container(
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
                  const CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                    child: Icon(Icons.person),
                  ),
                  SizedBox(width: 10.w),
                    const Row(
                    children: [
                      Text(
                        'Welcome , ',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Islam',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.notifications,color: Colors.white,)
                ],
              ),
                SizedBox(height: 35.h),
              const Text(
                "Your current cars",
                style: TextStyle(
                    color: Color.fromRGBO(112, 112, 112, 1),
                    fontSize: 20),
              ),
                SizedBox(height: 20.h),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  children: List.generate(12, (index) {
                    return MyCustomWidget(index: index);
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomWidget extends StatelessWidget {
 final int index;
  const MyCustomWidget({super.key,required this.index});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(

      closedBuilder: (_, openContainer) {
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
                  const Text(
                    "Tesla Model 3",
                    style: TextStyle(
                        color: Colors.white, fontSize: 15),
                  ),

                  Hero(tag: index.toString(),child: Image.asset("assets/image/tesla.png",width: 100,height: 50)),
                  Hero(
                    tag: index.toString(),
                    child: SvgPicture.asset(
                      listCarBrands[index],
                      width: 20, // Adjust the width as needed
                      height: 20, // Adjust the height as needed
                    ),
                  ),
                  const SizedBox(height:   5),
                    Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [

                        Text(
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
      openColor: const Color.fromRGBO(34, 34, 34, 1),
      closedElevation: 50.0,
      closedColor: Colors.black,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      // closedColor: Colors.white,
      openBuilder: (_, closeContainer) {
        return   CarDetailsScreen(index:index ,);
      },
    );
  }
}

List<String> listCarBrands = [
  "assets/icons/bmw.svg",
  "assets/icons/acura.svg",
  "assets/icons/bentley.svg",
  "assets/icons/ferrari.svg",
  "assets/icons/ford.svg",
  "assets/icons/gmc.svg",
  "assets/icons/hyundai.svg",
  "assets/icons/lexus.svg",
  "assets/icons/mazda.svg",
  "assets/icons/mazda.svg",
  "assets/icons/mini.svg",
  "assets/icons/mini.svg",
  "assets/icons/mini.svg",
];


// Import package for date formatting

class AddCarBottomSheet extends StatefulWidget {
  const AddCarBottomSheet({super.key});

  @override
  _AddCarBottomSheetState createState() => _AddCarBottomSheetState();
}

class _AddCarBottomSheetState extends State<AddCarBottomSheet> {
  final TextEditingController _carNameController = TextEditingController();
  final TextEditingController _carModelController = TextEditingController();
  final TextEditingController _carKilometersController = TextEditingController();
  DateTime? _licenseFromDate;
  DateTime? _licenseToDate;
  String? _selectedCarBrand;
  final List<String> _carBrands = [
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Padding(
                padding: const EdgeInsets.only(left: 5,top: 5),
                child: Text(
                  "Add Car",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _carNameController,
                decoration: const InputDecoration(
                  labelText: "Car Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _carModelController,
                decoration: const InputDecoration(
                  labelText: "Car Model",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedCarBrand,
                onChanged: (value) {
                  setState(() {
                    _selectedCarBrand = value;
                  });
                },
                items: _carBrands.map((String brand) {
                  return DropdownMenuItem<String>(
                    value: brand,
                    child: Text(brand),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: "Car Brand",
                  border: OutlineInputBorder(),
                ),
              ),

              Row(
                children: [
                  Image.asset("assets/icons/licens.png",width: 40,height: 40),
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
                            _licenseFromDate = picked;
                          });
                        }
                      },
                      child: Text(
                        _licenseFromDate == null
                            ? 'Select License From Date'
                            : 'From: ${DateFormat('yyyy-MM-dd').format(_licenseFromDate!)}',
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
                            _licenseToDate = picked;
                          });
                        }
                      },
                      child: Text(
                        _licenseToDate == null
                            ? 'Select License To \nDate'
                            : 'To: ${DateFormat('yyyy-MM-dd').format(_licenseToDate!)}',
                      ),
                    ),
                  ),
                ],
              ),

              TextField(
                controller: _carKilometersController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Car Kilometers",
                  border: OutlineInputBorder(),
                ),
              ),

              // Add widget to select car image
              // Add button to submit data
              const SizedBox(height: 10),
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
                  const SizedBox(width:10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Add functionality to submit data
                      // Access data using _carNameController.text, _carModelController.text, etc.
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

