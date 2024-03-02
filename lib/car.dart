import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'home.dart';


class CarDetailsScreen extends StatelessWidget {
  int index;
    CarDetailsScreen({super.key,required this.index});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
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
                  padding: const EdgeInsets.only(right: 25.0, left: 25.0 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 15,),
                          Text(
                            "Your current car",
                            style: TextStyle(
                                color: const Color.fromRGBO(112, 112, 112, 1),
                                fontSize: height / 45),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Tesla Model 3",
                            style: TextStyle(
                                color: Colors.white, fontSize: height / 32),
                          )
                        ],
                      ),
                      Hero(
                        tag: index.toString(),
                        child: SvgPicture.asset(
                          listCarBrands[index],
                          width: 50, // Adjust the width as needed
                          height: 50, // Adjust the height as needed
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
                      height: height / 4,
                      width: width,
                      decoration: const BoxDecoration(
                        // color: Colors.red,
                          image: DecorationImage(
                              image: AssetImage("assets/image/tesla.png"),
                              fit: BoxFit.contain)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    height: height / 4,
                    width: width,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      // Add this line for bounce effect
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return
                          index == 0 ?
                          testab(const Icon(
                              Icons.car_crash, color: Colors.white), "Battery",
                              "71%", (height / 4) / 5, "210 mi left", true,context) :
                          index == 1 ?
                          testab(
                              const Icon(Icons.car_crash, color: Colors.white),
                              "Mileage",
                              "10345 mi", (height / 4) / 9, "+ 23 min today",
                              true,context) :
                          index == 2 ?
                          testab(
                              const Icon(Icons.car_crash,
                                  color: Colors.white),
                              "Temperature",
                              "39%",
                              (height / 4) / 5,
                              "Choke free",
                              true,context) : const SizedBox();
                      },
                      separatorBuilder: (context, index) =>
                      const SizedBox(width: 15),

                    ),
                  ),
                ),
                SizedBox(
                  height: height / 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    "Suggested Ports",
                    style: TextStyle(
                        color: const Color.fromRGBO(115, 115, 115, 1),
                        fontSize: height / 50),
                  ),
                ),
                SizedBox(
                  height: height / 30,
                ),
                SizedBox(
                  height: height / 7,
                  width: width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      parts("assets/image/charger.png", "Fast Charger", "499",context),
                      parts("assets/image/tires.png", "Tires", "199",context)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget testab(Icon icons, String iconname, String details,
      double detailsheigth, String detaildata, bool see,context) {
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
            height:10,
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


  Widget parts(String image, String product, String cost,context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: SizedBox(
        height:100,
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
                          style: TextStyle(
                              color: Colors.white, fontSize: 20),
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
