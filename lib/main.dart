import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gestion_emploi_temps/view/pageAcceuil_Admin/Spash.view.dart';
import 'package:gestion_emploi_temps/view/pageAcceuil_Admin/home.dart';
import 'package:get/get.dart';

import 'Etudiant/EtudiantAcceuil.dart';



void main()async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(  const MyApp());   
}


final navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      home:EtudiantAcceuil(),//SplashView(),//CoursView(),//HomePage(),//
      debugShowCheckedModeBanner: false, 

    );
  }
}



