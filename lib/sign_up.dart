import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        backgroundColor: const Color(0xFF212121),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF909093)),
          onPressed: () => Navigator.of(context).pop(),
        ),



      ),


      body:Container(

        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF212121),


        ),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[


            Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children:<Widget>[

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),


                      const Text('Sign up to see photos\nand videos from your\nfriends.',style:
                      TextStyle(
                          color: Color(0xFF909093),
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),
                      ),
                      // ),

                      const SizedBox(height: 30),


                      SizedBox(
                        width: 320,


                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[


                            Container(

                              decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey))
                              ),
                              child: const TextField(
                                style: TextStyle(
                                  color: Colors.white,

                                ),

                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    hintText: "Mobile Number or Email",
                                    hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent
                                        )
                                    )
                                ),
                              ),
                            ),

                            const SizedBox(height: 10,),



                            Container(

                              decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey))
                              ),
                              child: const TextField(
                                style: TextStyle(
                                  color: Colors.white,

                                ),
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    hintText: "UserName",
                                    hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent
                                        )
                                    )
                                ),
                              ),
                            ),

                            const SizedBox(height: 10,),


                            Container(

                              decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey))
                              ),

                              child: const TextField(
                                obscureText: true,
                                style: TextStyle(
                                  color: Colors.white,

                                ),
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blueAccent)
                                    )
                                ),

                              ),
                            ),

                            const SizedBox(height: 60,),

                            Container(
                                height: 50,
                                width: 320,

                                // margin: EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFffb421),
                                        Color(0xFFff7521)
                                      ]
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.push(context,MaterialPageRoute(builder: (context) => SignUp()),);
                                  },
                                  child: Center(
                                    child: Text("Sign Up", style: TextStyle(fontSize: 18,color: Colors.white, fontWeight: FontWeight.bold),),
                                  ),
                                )
                            ),




                          ],
                        ),

                      ),


                      const SizedBox(height: 20),


                      const Text('Or sign up with another\naccount.',style:
                      TextStyle(
                          color: Color(0xFF909093),
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),
                      ),


                      const SizedBox(height: 20,),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Container(
                            child: SvgPicture.asset(
                              "assets/icons/icons-facebook.svg",
                              height: 35,
                              width: 35,
                            ),
                          ),
                          SizedBox(width: 50,),
                          Container(
                            child: SvgPicture.asset(
                              "assets/icons/icons-twitter.svg",
                              height: 35,
                              width: 35,
                            ),
                          ),
                          SizedBox(width: 50,),
                          Container(
                            child: SvgPicture.asset(
                              "assets/icons/icons-google.svg",
                              height: 35,
                              width: 35,
                            ),
                          ),
                          SizedBox(width: 50,),

                        ],
                      ),



                      const SizedBox(height: 20,),




                    ],
                  ),

                ]
            ),



          ],
        ),
      ),
    );
  }
}
