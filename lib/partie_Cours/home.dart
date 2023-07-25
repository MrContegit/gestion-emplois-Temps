import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestion_emploi_temps/constante/lesIcons.dart';
import 'package:gestion_emploi_temps/partie_Cours/user_info.dart';

import '../view/pageAcceuil_Admin/home.dart';
import 'head_list.dart';
import 'head_list_view.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, this.map,this.map2});
  Map<String,String>? map;
  Map<int,String>? map2;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selected = 0;
  final pageController = PageController();
  final TextEditingController rechercheController=TextEditingController();
  Map<String,String>? mape = {
    'classe' :'3IL3',
    'semaine' :'jj/mm/aa..',
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
        backgroundColor: Colors.blue.withOpacity(0.1),

        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_outlined),
              onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder:(context)=>const HomePageAdmin()));
              }),
          actions: [
            IconButton(
              icon: const Icon(Icons.search_outlined),
              onPressed: () {
                //voir les resultats des votes
              },
            )
          ],
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfo(map:widget.map ?? mape),
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