import 'package:flutter/material.dart';
import '/util/color.dart' as color;

class INfoVideo extends StatefulWidget {
  const INfoVideo({super.key});

  @override
  State<INfoVideo> createState() => _INfoVideoState();
}

class _INfoVideoState extends State<INfoVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.AppColor.gradiantFirst.withOpacity(0.9),
              color.AppColor.gradiantSecond,
            ],
            begin: const FractionalOffset(0.0, 0.4),
            end: Alignment.topRight,
          )
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.arrow_back_ios,size: 20,
                      color: color.AppColor.secondPageIconColor,),
                      Expanded(child: Container()),
                      Icon(Icons.info_outline,size: 20,
                      color: color.AppColor.secondPageIconColor,)
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Legs Toning",
                    style: TextStyle(
                      fontSize: 25,
                      color: color.AppColor.secondPageTitleColor,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "and Glutes workout",
                    style: TextStyle(
                      fontSize: 25,
                      color: color.AppColor.secondPageTitleColor,
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Container(
                        width: 90,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              color.AppColor.secondPageContainerGradient1stColor,
                              color.AppColor.secondPageContainerGradient2stColor
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ) 
                          
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.timer,
                              size: 20,
                              color:color.AppColor.secondPageIconColor ,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "68 min",
                              style: TextStyle(
                                fontSize: 16,
                                color: color.AppColor.secondPageIconColor
                              ),
                            ),
                          ],
                        )
                      ),
                      SizedBox(width: 20),
                      Container(
                        width: 240,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              color.AppColor.secondPageContainerGradient1stColor,
                              color.AppColor.secondPageContainerGradient2stColor
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ) 
                          
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.handyman_outlined,
                              size: 20,
                              color:color.AppColor.secondPageIconColor ,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Resistent band, kettebell",
                              style: TextStyle(
                                fontSize: 16,
                                color: color.AppColor.secondPageIconColor
                              ),
                            ),
                          ],
                        )
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70),
                  )
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Row(
                      children: [
                        SizedBox(width: 30),
                        Text(
                          "Circuit 1:Legs Toning",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: color.AppColor.circuitsColor
                          ),
                        ),
                        Expanded(child: Container()),
                        Row(
                          children: [
                            Icon(Icons.loop,
                            size: 30,
                            color: color.AppColor.loopColor,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "3 sets",
                              style: TextStyle(
                                fontSize: 15,
                                color: color.AppColor.setsColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 20),
                      ],
                    )
                  ],
                ),
              ),
            )
          
          ],
        ),
      ),
    );
  }
}