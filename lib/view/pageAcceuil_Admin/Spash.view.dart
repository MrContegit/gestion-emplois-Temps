import "dart:async";

import "package:flutter/material.dart";
import "package:gestion_emploi_temps/util/global.colors.dart";
import 'package:gestion_emploi_temps/view/connection_inscription/signin.dart';
import "package:get/get.dart";

class SplashView extends StatelessWidget{
  const SplashView({Key? key}) :  super(key: key);
  @override
  Widget build(BuildContext context){
    Timer(const Duration(seconds:1 ), () {
      Get.to(const SignIn());
    });
    return Scaffold(
        backgroundColor: GlobalColors.mainColor,
        body: const Center(
          child:Text(
            'Logo',
            style: TextStyle(
              color:Colors.white,
              fontSize: 35,
              fontWeight:FontWeight.bold, 
            ),
          ),
        ) 
    );
  }
}