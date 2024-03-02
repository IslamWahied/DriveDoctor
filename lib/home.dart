import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'car.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          print('Floating Action Button pressed');
        },
        child: Image.asset("assets/image/1.png"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {},
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Mail", icon: Icon(Icons.message)),
          BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(25.0),
        height: height,
        width: width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black, Color.fromRGBO(34, 34, 34, 1)],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter)),
        child:   Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 35,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                  child: Icon(Icons.person),
                ),
                SizedBox(width: 20.0),
                Row(
                  children: [
                    Text(
                      'Welcome , ',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Islam',
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Expanded(
              child: GridView.count(

                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,

                padding: const EdgeInsets.all(8.0),
                children: List.generate(12, (index) {
                  return    MyCustomWidget(index:index ,);
                }),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

 class MyCustomWidget extends StatelessWidget {
  int index;
     MyCustomWidget({super.key,required this.index});

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
                   Text(
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
                   SizedBox(height:   5),
                   Center(
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [

                         Text(
                           "Kil 1355",
                           style: const TextStyle(color: Colors.white),
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

 List<String>  listCarBrands = [
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