import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestion_emploi_temps/Etudiant/EtudiantAcceuil.dart';
import 'package:gestion_emploi_temps/Etudiant/user_etud.dart';
import 'package:gestion_emploi_temps/constante/lesIcons.dart';
import 'package:gestion_emploi_temps/partie_Cours/user_info.dart';

import '../partie_Cours/head_list.dart';
import '../partie_Cours/head_list_view.dart';
import '../view/pageAcceuil_Admin/home.dart';

class PgCours extends StatefulWidget {
  PgCours({super.key, this.map,this.map2});
  Map<String,String>? map;
  Map<int,String>? map2;
  @override
  State<PgCours> createState() => _PgCoursState();
}

class _PgCoursState extends State<PgCours> {
  var selected = 0;
  final pageController = PageController();
  final TextEditingController rechercheController=TextEditingController();
  Map<String,String>? mape = {
    'classe' :'3IL3',
    'semaine' :'10/10/22',
    'semestre' :'semestre II',
    'salle' :'CH254'
  };
      Map<int,String> map3={
      1:'',
      2:'',
      3:'',
      4:'',
      5:'',
      6:'',
    };
    Map<int,String>  dates2(){
      final now = DateTime.now();
    late DateTime lastDayOfWeek = now.subtract(Duration(days: now.weekday - DateTime.saturday));
    map3[6] = '${lastDayOfWeek.day}/${lastDayOfWeek.month}/${lastDayOfWeek.year}';
    lastDayOfWeek = now.subtract(Duration(days: now.weekday - DateTime.friday));
    map3[5] = '${lastDayOfWeek.day}/${lastDayOfWeek.month}/${lastDayOfWeek.year}';
    lastDayOfWeek = now.subtract(Duration(days: now.weekday - DateTime.thursday));
    map3[4] = '${lastDayOfWeek.day}/${lastDayOfWeek.month}/${lastDayOfWeek.year}';
    lastDayOfWeek = now.subtract(Duration(days: now.weekday - DateTime.wednesday));
    map3[3] = '${lastDayOfWeek.day}/${lastDayOfWeek.month}/${lastDayOfWeek.year}';
    lastDayOfWeek = now.subtract(Duration(days: now.weekday - DateTime.tuesday));
    map3[2] = '${lastDayOfWeek.day}/${lastDayOfWeek.month}/${lastDayOfWeek.year}';
    lastDayOfWeek = now.subtract(Duration(days: now.weekday - DateTime.monday));
    map3[1] = '${lastDayOfWeek.day}/${lastDayOfWeek.month}/${lastDayOfWeek.year}';
    return map3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.withOpacity(0.7),

        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_outlined),
              onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder:(context)=>EtudiantAcceuil()));
              }),

        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserEtud(map:widget.map ?? mape),
          HeadList(
            selected, 
            (int index){
              setState(() {
                selected = index;
              });
              pageController.jumpToPage(index);
            }, 
          ),
          const SizedBox(height: 20,),
          
          Expanded(
            child: HeadListView(map2:widget.map2??dates2(),map:widget.map ?? mape!,
              selected,
              (int index){
                setState(() {
                  selected = index;
                });
              },
              pageController,
            )
          )
        ],
      ),
    );
  }
}